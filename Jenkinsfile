pipeline{
  agent any
  parameters{
//     string(name:'VERSION',defaultValue:'',description:'')
    choice(name: 'VERSION', choices:['1.0.1','1.0.2','1.0.3'], description:'')
    booleanParam(name:'executeTests',defaultValue:true,description:'')
  }
//   tools {
//     maven Maven
//     gradle Gradle
//   }
//   environment{
//     ENV_VERSION='1.3.6'
//     SERVER_CREDENTIALS=credentials('server-credentials')
//   }
  stages{
    stage("build"){
      steps{
        echo 'Building the application'
//         echo "Version involved is ${ENV_VERSION}"
      }
    }
    stage("test"){
      when{
        expression{
          params.executeTests
//           BRANCH_NAME='dev'
        }
      }
      steps{
        echo 'Testing the application'
//         withcredentials([ 
//           usernamePassword(credentials:'server-credentials',usernameVariable:USER, passwordVariable:PASSWORD)
//         ]){
//           echo 'We can use shell script or something to use the credentials'
//         }
      }
    }
    stage("deploy"){
      steps{
        echo 'Deploying the application'
        echo "The deployed version is ${params.VERSION}"
      }
    }
  }
//   post{
//     always{
//       //irrespective of the status of the stages this would be happening
//     }
//     success{ //failure
//       //when there is a change in build status or status in general
//     }
//   }
}
    
