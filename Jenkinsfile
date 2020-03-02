node(){

  stage ('Clonegit_Dockerfile'){  
    git url: 'https://github.com/aaugrain/projet_terraform',
      branch: 'master'
    withCredentials([file(credentialsId: 'bob', variable: 'lapointe')]) {
      sh 'cd terraform/terraform_noeud'
      sh 'pwd'
      sh 'terraform init'
      sh 'terraform apply -auto-approve -var-file=main.tfvars'
    }  
  }

  stage('Publish test results') {
    junit 'target/surefire-reports/*.xml'
  }

}
