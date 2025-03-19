pipeline {
    agent any

    tools {
        maven 'maven'
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
                sh 'mvn install'
            }
        }

        stage('Verify WAR File') {
            steps {
                script {
                    // Vérifie que le fichier .war est bien généré
                    if (!fileExists('target/javulna-1.0-SNAPSHOT.war')) {
                        error("Le fichier WAR n'a pas été généré.")
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construit l'image Docker
                    docker.build("javulna-0.1")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Exécute le conteneur Docker
                    docker.image("javulna-0.1").run("-p 8080:8080")
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline exécuté avec succès !'
        }
        failure {
            echo 'Pipeline a échoué. Consultez les logs pour plus de détails.'
        }
    }
}
