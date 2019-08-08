#!groovy
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
                        ))
        ])

        def TAG = "$BRANCH_NAME-$BUILD_NUMBER"

        def URL = "registry-nexus.melkouhen.net"

        def IMAGE = "elkouhen/books-api"

        stage('CHECKOUT') {
            checkout scm
        }

        container('docker') {

            stage('BUILD') {

                withCredentials([string(credentialsId: 'registry_url', variable: 'registry_url'),
                                 usernamePassword(credentialsId: 'nexus_user', passwordVariable: 'pass', usernameVariable : 'user' )]) {

                     withDockerRegistry(credentialsId: 'nexus_user', url: "${registry_url}") {

                        //sh "docker login -u ${user} -p ${pass} "

                        sh "docker build . -f Dockerfile --tag ${URL}/repository/docker-repository/${IMAGE}:$TAG"

                        sh "docker push ${URL}/repository/docker-repository/${IMAGE}:$TAG"
                    }
                }
            }
        }

        stage('RUN') {

            if (BRANCH_NAME == 'develop') {
                build job: "/app-chart-run/$BRANCH_NAME",
                        wait: false,
                        parameters: [string(name: 'image', value: "$TAG"),
                                     string(name: 'chart', value: "books-api")]
            }
        }
    }
}
