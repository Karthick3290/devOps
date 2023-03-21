def buildApp(){
  echo 'This is run by a groovy script for building the application..'
}
return this


def testApp(){
  echo 'This is run by a groovy script for testing the application..'
}
return this

def deployApp(){
  echo 'This is run by a groovy script for deploying the application..'
  echo "The deployed version is ${params.VERSION}"
}
return this
