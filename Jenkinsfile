#!groovy
import java.text.*

// pod utilisé pour la compilation du projet
podTemplate(label: 'books-api-pod', nodeSelector: 'medium', containers: [

        // le slave jenkins
        containerTemplate(name: 'jnlp', image: 'jenkinsci/jnlp-slave:alpine'),

        // un conteneur pour construire les images docker
        containerTemplate(name: 'docker', image: 'docker:18.09', command: 'cat', ttyEnabled: true)],

        // montage nécessaire pour que le conteneur docker fonction (Docker In Docker)
        volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]
) {

    node('books-api-pod') {

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

        def TAG = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())

        stage('CHECKOUT') {
            git branch: env.BRANCH_NAME, credentialsId: 'elkouhen-github', url: 'https://github.com/SofteamOuest-Opus/books-api.git'
        }

        container('docker') {

            stage('BUILD') {

                withCredentials([string(credentialsId: 'sonarqube_token', variable: 'sonarqube_tok'),
                                 string(credentialsId: 'registry_url', variable: 'registry_url')]) {

                    withDockerRegistry(credentialsId: 'nexus_user', url: "${registry_url}") {
                        sh "docker build . --build-arg SONAR_TOKEN=${sonarqube_tok} --tag registry.k8.wildwidewest.xyz/repository/docker-repository/opus/books-api:$TAG"

                        sh "docker push registry.k8.wildwidewest.xyz/repository/docker-repository/opus/books-api:$TAG"
                    }
                }
            }
        }

        stage('RUN') {

            build job: "/SofteamOuest-Opus/chart-run/master",
                    wait: false,
                    parameters: [string(name: 'image', value: "$TAG"),
                                 string(name: 'chart', value: "books-api")]
        }

    }
}
