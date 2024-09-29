pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('access-ket')
        AWS_SECRET_ACCESS_KEY = credentials('secret-key')

    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout code from your repository
                git branch: 'master', url: 'https://github.com/berezovsky13/spring-boot.git'
            }
        }

        stage('Set up AWS Credentials') {
            steps {
                // Set up AWS credentials for CLI usage
                sh '''
                aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                aws configure set default.region $AWS_DEFAULT_REGION
                '''
            }
        }

        stage('Login to ECR') {
            steps {
                // Log in to Amazon ECR
                sh '''
                aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 339712784473.dkr.ecr.us-east-1.amazonaws.comL
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image
                sh '''
                docker build -t daniel .
                '''
            }
        }

        stage('Tag Docker Image') {
            steps {
                // Tag Docker image
                sh '''
                docker tag daniel:latest 339712784473.dkr.ecr.us-east-1.amazonaws.com/daniel:latest
                '''
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                // Push Docker image to ECR
                sh '''
                docker push 339712784473.dkr.ecr.us-east-1.amazonaws.com/daniel:latest
                '''
            }
        }

        stage('Install Terraform') {
            steps {
                // Install Terraform
                sh '''
                sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
                curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
                sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
                sudo apt-get update && sudo apt-get install terraform
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                // Initialize Terraform
                sh 'terraform init'
            }
        }

        stage('Terraform Apply') {
            steps {
                // Apply Terraform configurations
                sh 'terraform apply -auto-approve'
                
            }
        }
    }

    post {
        always {
            // Clean up workspace after build
            cleanWs()
        }
    }
}
