pipeline {
    agent any

    stages {
        
        stage('Checkout Code') {
            steps {
                echo 'Cloning the spring-boot repository...'
                git url: 'https://github.com/berezovsky13/spring-boot.git', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}
