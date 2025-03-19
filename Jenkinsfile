pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'javulna-0.1' // Nom de l'image Docker
        DOCKER_CONTAINER = 'javulna-container' // Nom du conteneur Docker
        APP_PORT = '8080' // Port de l'application
    }

    tools {
        maven 'maven'
        git 'System-Git'
    }

    stages {
        stage('Checkout Source') {
            steps {
                git 'https://github.com/medboba/javulna.git'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Docker Deploy') {
            steps {
                script {
                    sh "docker stop ${DOCKER_CONTAINER} || true"
                    sh "docker rm ${DOCKER_CONTAINER} || true"
                    sh "docker run -d -p ${APP_PORT}:${APP_PORT} --name ${DOCKER_CONTAINER} ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Validate Deployment') {
            steps {
                script {
                    // Attendre que l'application soit prête
                    sleep(time: 10, unit: 'SECONDS')
                    // Vérifier que l'application répond
                    sh "curl -f http://localhost:${APP_PORT} || exit 1"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline exécuté avec succès !'
        }
        failure {
            echo 'Le pipeline a échoué.'
        }
    }
}
