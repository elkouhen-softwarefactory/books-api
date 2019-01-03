#!groovy
import java.text.*

// pod utilisé pour la compilation du projet
podTemplate(label: 'books-api-pod', nodeSelector: 'medium', containers: [

        // le slave jenkins
        containerTemplate(name: 'jnlp', image: 'jenkinsci/jnlp-slave:alpine'),

        // un conteneur pour le build maven
        containerTemplate(name: 'maven', image: 'maven', privileged: true, ttyEnabled: true, command: 'cat'),

        // un conteneur pour construire les images docker
        containerTemplate(name: 'docker', image: 'docker:18.09', command: 'cat', ttyEnabled: true)],

        // montage nécessaire pour que le conteneur docker fonction (Docker In Docker)
        volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]
) {

    node('books-api-pod') {

        def branch = env.JOB_NAME.replaceFirst('.+/', '');

        properties([
                buildDiscarder(
                        logRotator(
                                artifactDaysToKeepStr: '1',
                                artifactNumToKeepStr: '1',
                                daysToKeepStr: '3',
                                numToKeepStr: '3'
                        )
                )
        ])

        def now = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())

        stage('CHECKOUT') {
            checkout scm
        }

        container('docker') {

            stage('BUILD DOCKER IMAGE') {

                withCredentials([usernamePassword(credentialsId: 'nexus_user', usernameVariable: 'username', passwordVariable: 'password'),
                                string(credentialsId: 'sonarqube_token', variable: 'token')]) {

                    sh "docker login -u ${username} -p ${password} registry.k8.wildwidewest.xyz"

                    sh "docker build . --build_arg SONAR_TOKEN=${token} --tag registry.k8.wildwidewest.xyz/repository/docker-repository/opus/books-api:$now"

                    sh "docker push registry.k8.wildwidewest.xyz/repository/docker-repository/opus/books-api:$now"
                }
            }
        }

        stage('RUN') {

            build job: "/SofteamOuest-Opus/chart-run/master",
                    wait: false,
                    parameters: [string(name: 'image', value: "$now"),
                                 string(name: 'chart', value: "books-api")]
        }

    }
}
