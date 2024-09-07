pipeline {
  agent any
  environment {
    MAVEN_HOME = tool name: 'maven' , type:'maven'
  }
  stages{
    stage('Clone the Repository'){
      steps{
        git branch: 'health', credentialsId: 'GitHub', url: 'https://github.com/charannk007/Health-Care-Staragile.git'
      }
    }
    stage('Build the Repository'){
      steps{
        script {
                    echo "Maven Home: ${env.MAVEN_HOME}"
                    sh "${MAVEN_HOME}/bin/mvn -version"
                    sh "${MAVEN_HOME}/bin/mvn clean package"
        }
      }

  }
}
}