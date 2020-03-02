node(){

  stage ('Clonegit_Dockerfile'){  
    git url: 'https://github.com/aaugrain/projet_terraform',
      branch: 'master'
  }
  
  stage ('tot') {
    withCredentials([file(credentialsId: 'bob', variable: 'lapointe')]) {
      sh '''
      cd /data/jenkins/workspace/C-PAS-1-PIPE/C-1-TUBE/terraform/terraform_noeud
      pwd
      ls -al
      terraform init
      terraform apply -auto-approve -var-file=main.tfvars
      '''
    }  
  }

  stage('Publish test results') {
    junit 'target/surefire-reports/*.xml'
  }

}
