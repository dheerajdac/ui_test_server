pipeline {
    environment {
        registry = "dheerajdac/ui_test_server"
        registryqa01 = "dheerajdac/ui_test_server:qa01"
        registryCredential = 'dockerhub'
        dockerImage = ''
     }

    agent {
        docker {
            image 'dheerajdac/ubuntu:9'
            args '-v $HOME/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    stages {

        stage('Build') {
            steps {
                sh 'mvn -B clean package'
            }
        }

        stage('Building Image') {
            steps{
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }

        stage('Deploy Image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Building Image qa01') {
            steps{
                script {
                    dockerImage = docker.build registryqa01
                }
            }
        }

        stage('Deploy Image qa01') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Remove Unused docker image') {
            steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
                sh "docker rmi $registryqa01"
            }
        }
    }

    post{
        always{
            sh 'mvn clean'
        }
    }
}
