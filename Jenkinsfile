node(){

  stage ('Clonegit_Dockerfile'){  
    git url: 'https://github.com/aaugrain/projet_terraform',
      branch: 'master'
  }
  
  
  stage ('tot') {
 //   withCredentials([file(credentialsId: 'bob', variable: 'lapointe')]) {
    withCredentials([azureServicePrincipal('AZURCRE')]) {
      sh '''
      cd terraform/terraform_noeud
      pwd
      ls -al
      terraform init
      terraform plan -var-file=main.tfvars
      '''
    }  
  }

  stage('Publish test results') {
    junit 'target/surefire-reports/*.xml'
  }

}
