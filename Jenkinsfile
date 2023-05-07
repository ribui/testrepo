pipeline {
  agent any
  
  stages {
    stage('Authenticate with AWS') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
          credentialsId: 'AWS_Credentials'
        ]]) {
          sh 'export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID'
          sh 'export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY'
          sh 'echo "Successfully authenticated with AWS"'
          sh 'terraform init'
          sh 'terraform plan -out=tfplan'
          sh 'terraform apply --auto-approve tfplan'
        }
      }
    }
    
    stage('Build Docker Frontend and Backend Images') {
      steps {
        script {
          docker.build('my-docker-image:latest', '.')
        }
        sh 'echo "Successfully Built Docker Frontend and Backend Images using Dockerfile"'
      }
    }
    
    stage('Push Images to ECR') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
          credentialsId: 'AWS_Credentials'
        ]]) {
        sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 160503865246.dkr.ecr.us-east-1.amazonaws.com'
        sh 'docker push 160503865246.dkr.ecr.us-east-1.amazonaws.com/docker-test:latest'
        sh 'echo "Successfully Authenticated with AWS"'
        sh 'echo "Pushing Images to ECR..."'
        }
      }
    }
    
    stage('Deploy to ECS') {
      steps {
        sh 'echo "Successfully Authenticated with AWS"'
        sh 'echo "Deploying Images to ECS..."'
      }
    }
  }
}
