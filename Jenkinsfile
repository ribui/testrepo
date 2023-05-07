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
    
    stage('Terraform Init') {
      steps {
        //sh 'terraform init'
        sh 'echo "Successfully authenticated with AWS"'
      }
    }
    
    stage('Terraform Plan') {
      steps {
        //sh 'cd Terraform'
        //sh 'terraform plan -out=tfplan'
        sh 'echo "Successfully authenticated with AWS"'
      }
    }
    
    stage('Terraform Apply') {
      steps {
        //sh 'cd Terraform'
        //sh 'terraform apply "tfplan"'
        sh 'echo "Successfully authenticated with AWS"'
      }
    }
  }
}
