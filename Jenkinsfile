@Library('deploy-library') import com.softeam.deploy.DeployHelper

def utils = new DeployHelper(this)

// pod utilisé pour la compilation du projet
podTemplate(label: 'helloworld-simple-pod', nodeSelector: 'medium', containers: [

        // le slave jenkins
        containerTemplate(name: 'jnlp', image: 'jenkinsci/jnlp-slave:alpine'),

        // un conteneur pour le build maven
        containerTemplate(name: 'gradle', image: 'elkouhen/gradle-docker', privileged: true, ttyEnabled: true, command: 'cat'),

        // un conteneur pour construire les images docker
        containerTemplate(name: 'docker', image: 'tmaier/docker-compose', command: 'cat', ttyEnabled: true),

        // un conteneur pour déployer les services kubernetes
        containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl', command: 'cat', ttyEnabled: true)],

        // montage nécessaire pour que le conteneur docker fonction (Docker In Docker)
        volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]
) {

    node('helloworld-simple-pod') {

        def branch = env.JOB_NAME.replaceFirst('.+/', '');

        String now = ""

        properties([
                parameters([
                        booleanParam(defaultValue: false, description: '', name: 'DO_RELEASE'),
                        string(defaultValue: '', description: '', name: 'RELEASE_VERSION', trim: false),
                        string(defaultValue: '', description: '', name: 'NEXT_DEV_VERSION', trim: false)]),
                buildDiscarder(
                        logRotator(
                                artifactDaysToKeepStr: '1',
                                artifactNumToKeepStr: '1',
                                daysToKeepStr: '3',
                                numToKeepStr: '3'
                        )
                )
        ])

        stage('CHECKOUT') {
            checkout scm
        }

        container('gradle') {

            stage('BUILD SOURCES') {
                withCredentials([string(credentialsId: 'sonarqube_token', variable: 'token')]) {

                    configFileProvider([configFile(fileId: 'gradle.properties', targetLocation: "gradle.properties"),
                                        configFile(fileId: 'id_rsa', targetLocation: "/home/jenkins/.ssh/id_rsa"),
                                        configFile(fileId: 'id_rsa.pub', targetLocation: "/home/jenkins/.ssh/id_rsa.pub")

                    ]) {

                        if (!params.DO_RELEASE) {

                            sh 'gradle clean build publish -Dsonar.login=${token}'
                        } else {

                            utils.configureGIT()

                            sh "gradle release -Prelease.useAutomaticVersion=true -Prelease.releaseVersion=${params.RELEASE_VERSION} -Prelease.newVersion=${params.NEXT_DEV_VERSION}"
                        }
                    }
                }
            }
        }

        container('docker') {

            stage('BUILD DOCKER IMAGE') {

                utils.configureDockerRegistry()

                withCredentials([usernamePassword(credentialsId: 'nexus_user', usernameVariable: 'username', passwordVariable: 'password')]) {

                    sh "docker login -u ${username} -p ${password} registry.k8.wildwidewest.xyz"
                }

                if (!params.DO_RELEASE) {
                    now = sh (script: 'cat version.properties | cut -d= -f2', returnStdout: true).trim()

                } else {
                    now = params.RELEASE_VERSION
                }

                sh "tag=${now} docker-compose build"

                sh "tag=${now} docker-compose push"
            }
        }

        container('kubectl') {

            stage('RUN') {

                build job: "/Helloworld-K8s/chart-run/master",
                        wait: false,
                        parameters: [string(name: 'image', value: "$now"),
                                     string(name: 'chart', value: "helloworld-simple")]
            }
        }
    }
}
