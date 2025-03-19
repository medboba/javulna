pipeline {
    agent any // Spécifie que le pipeline peut s'exécuter sur n'importe quel agent disponible

    tools { // Configure les outils utilisés dans le pipeline
        maven 'maven' // Spécifie l'outil Maven à utiliser
    }

    stages { // Définit les différentes étapes du pipeline
        stage('Checkout Source') { // Étape pour récupérer le code source
            steps {
                git 'https://github.com/medboba/javulna.git' // Récupère le code source depuis GitHub
            }
        }

        stage('Unit Test') { // Étape pour exécuter les tests unitaires
            steps {
                sh 'mvn test' // Exécute les tests unitaires avec Maven
            }
        }

        stage('Build') { // Étape pour construire le projet
            steps {
                sh 'mvn install' // Construit le projet avec Maven
            }
        }

        stage('Build Docker Image') { // Étape pour construire l'image Docker
            steps {
                script {
                    // Construit l'image Docker en utilisant le Dockerfile
                    docker.build("javulna-0.1")
                }
            }
        }

        stage('Run Docker Container') { // Étape pour exécuter le conteneur Docker
            steps {
                script {
                    // Exécute le conteneur Docker en mappant le port 8080
                    docker.image("javulna-0.1").run("-p 8080:8080")
                }
            }
        }
    }

    post { // Actions post-build
        success {
            echo 'Pipeline exécuté avec succès !'
        }
        failure {
            echo 'Pipeline a échoué !'
        }
    }
}
