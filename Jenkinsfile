pipeline {
  agent any
  environment {
    MAVEN_HOME = tool name: 'maven', type: 'maven'
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

    // ********************************************************************************* //
    stage('Docker Login') {
      steps {
        script {
          withCredentials([usernamePassword(credentialsId: 'dockerhubs', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
          }
        }
      }
    }
    // ********************************************************************************* //
    // stage('Build the Docker Image') {
    //   steps {
    //     sh 'docker build -t capstonehealth .'
    //   }
    // }
    // // ********************************************************************************* //
    // stage('Push the Image to Docker Hub') {
    //   steps {
    //     script {
    //       sh 'docker tag capstonehealth ${DOCKER_USERNAME}/capstonehealth:latest'
    //       sh 'docker push ${DOCKER_USERNAME}/capstonehealth:latest'
    //     }
    //   }
    // }
  }
}
