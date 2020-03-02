node(){

  stage ('Clonegit_Dockerfile'){  
    git url: 'https://github.com/aaugrain/projet_terraform',
      branch: 'master'
  }
 /*
  terraform {
    backend "azurerm" {
      bucket = "kiki.tfstate"
      credentials = "./creds/serviceaccount.json"
    }
  }
  */
  stage('TF Plan') {
//    container('richard3') {
    withCredentials([file(credentialsId: 'bob', variable: 'lapointe')]) {
      sh 'cd terraform/terraform_noeud'
      sh 'terraform init'
      sh 'terraform plan -auto-approve -var-file=main.tfvars'
//    }
    }  
  }
  
  stage('Publish test results') {
    junit 'target/surefire-reports/*.xml'
  }

}
