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
          docker.build('my-docker-image:latest', './frontend')
          docker.build('my-backend-image:latest', './backend')
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
         
        sh 'echo "Tagging and pushing the my-docker-image to ECR"'
        sh 'docker tag my-docker-image:latest 160503865246.dkr.ecr.us-east-1.amazonaws.com/docker-test:latest'
        sh 'docker push 160503865246.dkr.ecr.us-east-1.amazonaws.com/docker-test:latest'
        sh 'echo "Succefully Tagged and pushed my-docker-image to ECR"'
        
        sh 'echo "Tagging and pushing the my-backend-image to ECR"'
        sh 'docker tag my-backend-image:latest 160503865246.dkr.ecr.us-east-1.amazonaws.com/docker-test:latest'  
        sh 'docker push 160503865246.dkr.ecr.us-east-1.amazonaws.com/docker-test:latest'
        sh 'echo "Tagging and pushing the my-docker-image to ECR"'
         
        sh 'echo "TAGGING AND PUSHING IMAGES TO ECR SUCCESS....."'
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
