pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/berezovsky13/spring-boot.git', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                withMaven(maven: 'Maven-3.8.5') { 
                    bat 'mvn clean package'
                }
            }
        } 
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}
