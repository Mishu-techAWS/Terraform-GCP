pipeline {
    agent any
	
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-service-account')
	
    }
	
    stages {
        stage('Git Checkout') {
            steps {
               git branch: 'main', url: 'https://github.com/Mishu-techAWS/Terraform-GCP.git'
            }
        }
        
        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init  -reconfigure'
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }
        stage('Manual Approval') {
            steps {
                input "Approve?"
            }
        }
	 
	    
        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply tfplan'
                }
            }
        }
    }
}
