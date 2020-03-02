node(){

/* Définition du terraform Backend
  terraform {
    backend "azurerm" {
      resource_group_name  = "6lv1"
      storage_account_name = "storagedesespoir"
      container_name       = "richard3"
      key                  = "kiki.tfstate"
      subscription_id = "092ad35b-0094-4eed-884b-a06a335fbb3a"
      client_id = "9c19e318-731f-4305-a5c7-d6307a8f4ff2"
      client_secret = "49778169-bc89-4a5c-9fbc-44ecf67a3b1e"
      tenant_id = "7a34e3a4-1808-4c92-946a-b78e8f9bdfd5"
    }
  }
*/

  stage ('Clonegit_Dockerfile'){  
    git url: 'https://github.com/aaugrain/projet_terraform',
      branch: 'master'
  }
  
  terraform {
    backend "azurerm" {
      bucket = "kiki.tfstate"
      credentials = "./creds/serviceaccount.json"
    }
  }
  
  
  stage('TF Plan') {
//    container('richard3') {
      sh 'terraform init'
      sh 'terraform plan -var-file= -var-file=main.tfvars'
//    }
  }

  
  stage('Publish test results') {
    junit 'target/surefire-reports/*.xml'
  }

}
