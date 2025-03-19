pipeline {
    agent any // Spécifie que le pipeline peut s'exécuter sur n'importe quel agent disponible

    tools { // Configure les outils utilisés dans le pipeline
        maven 'maven' // Spécifie l'outil Maven à utiliser
    }

    stages { // Définit les différentes étapes du pipeline
        stage('Checkout Source') { // Étape de récupération du code source
            steps {
                git 'https://github.com/medboba/javulna.git' // Récupère le code source depuis le dépôt GitHub
            }
        }

        stage('Unit Test') { // Étape de tests unitaires
            steps {
                sh 'mvn test' // Exécute les tests unitaires avec Maven
            }
        }

        stage('Build') { // Étape de construction du projet
            steps {
                sh 'mvn clean install' // Nettoie et construit le projet avec Maven
            }
        }

        stage('Docker Build') { // Étape de construction de l'image Docker
            steps {
                script {
                    // Construit l'image Docker à partir du Dockerfile
                    sh 'docker build -t javulna-0.1 .'
                }
            }
        }

        stage('Docker Deploy') { // Étape de déploiement du conteneur Docker
            steps {
                script {
                    // Arrête et supprime l'ancien conteneur (s'il existe)
                    sh 'docker stop javulna-container || true'
                    sh 'docker rm javulna-container || true'

                    // Démarre un nouveau conteneur à partir de l'image Docker
                    sh 'docker run -d -p 8080:8080 --name javulna-container javulna-0.1'
                }
            }
        }
    }

    post { // Actions à exécuter après les étapes du pipeline
        success {
            echo 'Pipeline exécuté avec succès !' // Affiche un message en cas de succès
        }
        failure {
            echo 'Le pipeline a échoué.' // Affiche un message en cas d'échec
        }
    }
}
