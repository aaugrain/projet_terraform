node(){

  stage ('Clonegit_Dockerfile'){  
    git url: 'https://github.com/aaugrain/projet_terraform',
      branch: 'master'
    withCredentials([file(credentialsId: 'bob', variable: 'lapointe')]) {
      sh 'sudo cd terraform/terraform_noeud'
      sh 'pwd'
      sh 'ls -al'
      sh 'sudo terraform init'
      sh 'sudo terraform apply -auto-approve -var-file=main.tfvars'
    }  
  }

  stage('Publish test results') {
    junit 'target/surefire-reports/*.xml'
  }

}
