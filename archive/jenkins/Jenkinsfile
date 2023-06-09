pipeline{
    agent any 
    environment{
        VERSION = "${env.BUILD_ID}"
    }
    stages{
        stage('Example Build') {
            agent { docker 'gradle:6-jdk8' } 
            steps {
                echo 'Hello, gradle'
                sh 'gradle --version'
                sh 'gradle clean build'
            }
        }
    }
}
