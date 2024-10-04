pipeline {
  agent any
  environment {
    AWS_ACCESS_KEY_ID = credentials('aws-access-key')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
  }
  stages {
    stage('build the project') {
      steps {
        git 'https://github.com/roopasuguna1234/Health-Care-Staragile1.git'
        sh 'mvn clean package'
      }
    }
    stage('Building docker image') {
      steps {
        script {
          sh 'docker build -t user977/health:v2 .'
          sh 'docker images'
        }
      }
    }
    stage('push to docker-hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
          sh "echo $PASS | docker login -u $USER --password-stdin"
          sh 'docker push user977/health:v2'
        }
      }
    }
    stage('Terraform Operations for test workspace') {
      steps {
        script {
          sh '''
            terraform workspace select test || terraform workspace new test
            terraform init
            terraform plan
            terraform destroy -auto-approve
          '''
        }
      }
    }
    stage('Terraform destroy & apply for test workspace') {
      steps {
        sh 'terraform apply -auto-approve'
      }
    }
    stage('get kubeconfig') {
      steps {
        sh 'aws eks update-kubeconfig --region us-east-1 --name test-cluster'
        sh 'kubectl get nodes'
      }
    }
    stage('Deploying the application') {
      steps {
        sh 'kubectl apply -f deploy.yaml'
        sh 'kubectl get svc'
      }
    }
    stage('Terraform Operations for Production workspace') {
      when {
        expression {
          return currentBuild.currentResult == 'SUCCESS'
        }
      }
      steps {
        script {
          sh '''
            terraform workspace select prod || terraform workspace new prod
            terraform init
            terraform plan
            terraform destroy -auto-approve
          '''
        }
      }
    }
    stage('Terraform destroy & apply for production workspace') {
      steps {
        sh 'terraform apply -auto-approve'
      }
    }
    stage('get kubeconfig for production') {
      steps {
        sh 'aws eks update-kubeconfig --region us-east-1 --name prod-cluster'
        sh 'kubectl get nodes'
      }
    }
    stage('Deploying the application to production') {
      steps {
        sh 'kubectl apply -f deploy.yaml'
        sh 'kubectl get svc'
      }
    }
  }
}
