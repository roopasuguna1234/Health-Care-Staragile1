pipeline {
  agent any
  environment {
    MAVEN_HOME = tool name: 'maven', type: 'maven'
    USER_NAME = 'nkcharan'
    DOCKERHUB_CREDENTIALS = credentials('dockerhubs')
  }
  stages {
    stage('Clone the Repository') {
      steps {
        git branch: 'health', credentialsId: 'git', url: 'https://github.com/charannk007/Health-Care-Staragile.git'
      }
    }

    // ********************************************************************************* //
    stage('Build the Repository') {
      steps {
        script {
          echo "Maven Home: ${env.MAVEN_HOME}"
          sh "${MAVEN_HOME}/bin/mvn -version"
          sh "${MAVEN_HOME}/bin/mvn clean package"
        }
      }
    }
    // **********************************************************
      stage('Build the Docker Image') {
      steps {
        sh 'docker build -t capstonehealth .'
      }
    }

    // ********************************************************************************* //
    stage('Docker Login') {
      steps {
        script {
          withCredentials([usernamePassword(credentialsId: 'dockerhubs', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
          }
        }
      }
    }
       // ********************************************************************************* //
    stage('Push the Image to Docker Hub') {
      steps {
        script {
          sh 'docker tag capstonehealth ${DOCKER_USERNAME}/capstonehealth:v1'
          sh 'docker push ${DOCKER_USERNAME}/capstonehealth:v1'
        }
      }
    }
  }
  post {
    success {
      script {
        echo 'Pipeline succeeded! Image has been pushed to Docker Hub.'
      }
    }
  }
}
