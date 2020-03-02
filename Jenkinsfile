# Définition du terraform Backend

terraform {
  backend "" {
    credentials = "./creds/serviceaccount.json"
  }
}

pipeline {
  agent any  environment {
    SVC_ACCOUNT_KEY = credentials('terraform-auth')
  }
  
    
    
  
  stages {
  stage('Checkout') {
    steps {
      checkout scm
      sh 'mkdir -p creds'
      sh 'echo $SVC_ACCOUNT_KEY | base64 -d > ./creds/serviceaccount.json'
    }
  }
  
  stage('TF Plan') {
       steps {
         container('terraform') {
           sh 'terraform init'
           sh 'terraform plan -out myplan'
         }
       }
     }
}
