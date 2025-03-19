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
                    try {
                        // Construit l'image Docker
                        docker.build("javulna-0.1")
                    } catch (Exception e) {
                        error("Échec de la construction de l'image Docker : ${e.getMessage()}")
                    }
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    try {
                        // Exécute le conteneur Docker
                        docker.image("javulna-0.1").run("-p 8080:8080")
                    } catch (Exception e) {
                        error("Échec de l'exécution du conteneur Docker : ${e.getMessage()}")
                    }
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
