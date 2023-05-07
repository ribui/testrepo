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
          sh 'terraform apply --auto-approve "tfplan"'
        }
      }
    }
    
    stage('build docker frontend and backend images using a dockerfile') {
      steps {
         dockerImage = docker.build registry
        //sh 'terraform init'
        sh 'echo "Successfully Build Docker Frontend and Backend Image using Dockerfile"'
      }
    }
    
    stage('push frontend and backend images to ecr') {
      steps {
        //sh 'cd Terraform'
        //sh 'terraform plan -out=tfplan'
        sh 'echo "Successfully authenticated with AWS"'
      }
    }
    
    stage('pull image from ecr and deploy to ecs') {
      steps {
        //sh 'cd Terraform'
        //sh 'terraform apply "tfplan"'
        sh 'echo "Successfully authenticated with AWS"'
      }
    }
  }
}
