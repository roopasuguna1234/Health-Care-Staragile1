pipeline {
  agent any
  environment {
    MAVEN_HOME = tool name: 'maven', type: 'maven'
    USER_NAME = 'nkcharan'
    IMAGE_NAME = 'updatedhealthproject'
    DOCKERHUB_CREDENTIALS = credentials('dockers')
    IMAGE_VERSION = 'v2'
  }
  stages {
    stage('Clone the Repository') {
      steps {
        git branch: 'health', credentialsId: 'git', url: 'https://github.com/charannk007/Health-Care-Staragile.git'
      }
    }

    stage('Build the Repository') {
      steps {
        script {
          echo "Maven Home: ${env.MAVEN_HOME}"
          sh "${MAVEN_HOME}/bin/mvn -version"
          sh "${MAVEN_HOME}/bin/mvn clean package"
        }
      }
    }

    stage('Docker Login') {
      steps {
        script {
          withCredentials([usernamePassword(credentialsId: 'dockers', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
          }
        }
      }
    }

    // stage('Removing existing Images and Containers') {
    //   steps {
    //     script {
    //       // Remove existing containers
    //       sh '''
    //       CONTAINERS=$(docker ps -aq)
    //       if [ "$CONTAINERS" ]; then
    //         docker rm -f $CONTAINERS
    //       else
    //         echo "No containers to remove"
    //       fi
    //       '''

    //       // Remove existing images
    //       sh '''
    //       IMAGES=$(docker images -q)
    //       if [ "$IMAGES" ]; then
    //         docker rmi -f $IMAGES
    //       else
    //         echo "No images to remove"
    //       fi
    //       '''
    //     }
    //   }
    // }

    stage('Build the Docker Image') {
      steps {
        sh 'docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} .'
      }
    }

    stage('Creating the Image Tag') {
      steps {
        sh 'docker tag ${IMAGE_NAME}:${IMAGE_VERSION} ${USER_NAME}/${IMAGE_NAME}:${IMAGE_VERSION}'
      }
    }

    stage('Docker Push Image') {
      steps {
        sh 'docker push ${USER_NAME}/${IMAGE_NAME}:${IMAGE_VERSION}'
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
