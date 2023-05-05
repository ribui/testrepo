pipeline {
  agent any
  
  environment {
    AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    AWS_DEFAULT_REGION    = 'us-east-1'
  }

  stages {
    stage('Authenticate with AWS') {
      steps {
        sh 'aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID'
        sh 'aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY'
        sh 'aws configure set region $AWS_DEFAULT_REGION'
      }
    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh 'terraform plan'
      }
    }

    stage('Terraform Apply') {
      steps {
        sh 'terraform apply -auto-approve'
      }
    }
  }
}

