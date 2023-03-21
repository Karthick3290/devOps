pipeline{
  agent any
  environment{
    ENV_VERSION='1.3.6'
    SERVER_CREDENTIALS=credentials('server-credentials')
  }
  stages{
    stage("build"){
      steps{
        echo 'Building the application'
        echo "Version involved is ${ENV_VERSION}"
      }
    }
    stage("test"){
      when{
        expression{
          BRANCH_NAME='dev'
        }
      }
      steps{
        echo 'Testing the application'
      }
    }
    stage("deploy"){
      steps{
        echo 'Deploying the application'
      }
    }
  }
  post{
    always{
      //irrespective of the status of the stages this would be happening
    }
    success{ //failure
      //when there is a change in build status or status in general
    }
  }
}
    
