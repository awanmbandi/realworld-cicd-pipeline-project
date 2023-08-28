pipeline {
  agent {
    label 'Gradle-Build-Env' // Use the Gradle slave node for this pipeline
  }
  stages {
    stage('Validate Project') {
        steps {
            sh 'gradle check'
        }
    }
    stage('Gradle Project Tasks'){
        steps {
            sh 'gradle tasks'
        }
    }
    stage('Unit & Integration Test'){
        steps {
            sh 'gradle test'
        }
    }
    stage('Package Application'){
        steps {
            sh 'gradle build'
        }
    }
    stage ('Checkstyle Code Analysis'){
        steps {
            sh 'gradle checkstyleTest'
        }
    }
    stage('SonarQube Inspection') {
        steps {
            sh 'gradle sonarqube'
        }
    }
    stage("Upload Artifact To Nexus"){
        steps{
            sh 'gradle publish'
        }
        post {
            success {
                echo 'Successfully Uploaded Artifact to Nexus Artifactory'
        }
      }
    }
  }
}

