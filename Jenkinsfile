def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]
pipeline {
  agent any
  environment {
    WORKSPACE = "${env.WORKSPACE}"
    //NEXUS_USER = "$NEXUS_CREDS_USR"
    //NEXUS_PASSWORD = "$Nexus-Token"
    //NEXUS_URL = "172.31.18.62:8081"
    //NEXUS_REPOSITORY = "maven_project"
    //NEXUS_REPO_ID    = "maven_project"
    NEXUS_CREDENTIAL_ID = 'Nexus-Credential'
    ARTVERSION = "${env.BUILD_ID}"
  }
  tools {
    maven 'localMaven'
    jdk 'localJdk'
  }
  stages {
    stage('Build') {
      steps {
        sh 'mvn clean package'
      }
      post {
        success {
          echo ' now Archiving '
          archiveArtifacts artifacts: '**/*.war'
        }
      }
    }
    stage('Unit Test'){
        steps {
            sh 'mvn test'
        }
    }
    stage('Integration Test'){
        steps {
          sh 'mvn verify -DskipUnitTests'
        }
    }
    stage ('Checkstyle Code Analysis'){
        steps {
            sh 'mvn checkstyle:checkstyle'
        }
        post {
            success {
                echo 'Generated Analysis Result'
            }
        }
    }
    stage('SonarQube scanning') {
        steps {
            withSonarQubeEnv('SonarQube') { 
                withCredentials([string(credentialsId: 'SonarQube-Token', variable: 'SONAR_TOKEN')]) {
                sh """
                mvn sonar:sonar \
                -Dsonar.projectKey=jjtech-cicd-pipeline \
                -Dsonar.host.url=http://172.31.83.105:9000 \
                -Dsonar.login=$SONAR_TOKEN
                """
                }
            }
        }
    }
    stage('Quality Gate') {
        steps {
          timeout(time : 1, unit : 'HOURS'){
          waitForQualityGate abortPipeline: true
          }
       }
    }
    stage("Nexus Artifact Uploader"){
        steps{
           nexusArtifactUploader(
              nexusVersion: 'nexus3',
              protocol: 'http',
              nexusUrl: '172.31.82.36:8081',
              groupId: 'webapp',
              version: "${env.BUILD_ID}-${env.BUILD_TIMESTAMP}",
              repository: 'maven-project-release',  //"${NEXUS_REPOSITORY}",
              credentialsId: "${NEXUS_CREDENTIAL_ID}",
              artifacts: [
                  [artifactId: 'webapp',
                  classifier: '',
                  file: '/var/lib/jenkins/workspace/jenkins-complete-cicd-pipeline/webapp/target/webapp.war',
                  type: 'war']
              ]
           )
        }
    }
    // stage('Upload artifact to Nexus') {
    //     steps {
    //         withCredentials([usernamePassword(credentialsId: 'Nexus-Credential', passwordVariable: 'PASSWORD', usernameVariable: 'USER_NAME')]) {
    //         sh 'sudo sed -i \'s/.*<username><\\/username>/<username>${USER_NAME}<\\/username>/g\' ${WORKSPACE}/jenkins-nexus/settings.xml'
    //         sh 'sudo sed -i \'s/.*<password><\\/password>/<password>${PASSWORD}<\\/password>/g\' ${WORKSPACE}/jenkins-nexus/settings.xml'
    //         sh 'sudo cp ${WORKSPACE}/jenkins-nexus/settings.xml /var/lib/jenkins/.m2'
    //         sh 'mvn clean deploy -DskipTests'
    //         }
    //     }
    // }
    // stage('Upload to Artifactory') {
    //   steps {
    //     sh "mvn clean deploy -DskipTests"
    //   }
    // }
    stage('Deploy to DEV env') {
        environment {
            HOSTS = 'dev'
        }
        steps {
            withCredentials([usernamePassword(credentialsId: 'ansible-credentials', passwordVariable: 'PASSWORD', usernameVariable: 'USER_NAME')]) {
                sh "ansible-playbook -i ${WORKSPACE}/ansible-setup/aws_ec2.yaml ${WORKSPACE}/deploy.yaml --extra-vars \"ansible_user=$USER_NAME ansible_password=$PASSWORD hosts=tag_Environment_$HOSTS workspace_path=$WORKSPACE\""
            }
        }
    }
    stage('Deploy to STAGE env') {
        environment {
            HOSTS = 'stage'
        }
        steps {
            withCredentials([usernamePassword(credentialsId: 'ansible-credentials', passwordVariable: 'PASSWORD', usernameVariable: 'USER_NAME')]) {
                sh "ansible-playbook -i ${WORKSPACE}/ansible-setup/aws_ec2.yaml ${WORKSPACE}/deploy.yaml --extra-vars \"ansible_user=$USER_NAME ansible_password=$PASSWORD hosts=tag_Environment_$HOSTS workspace_path=$WORKSPACE\""
            }
        }
    }
    stage('Approval') {
        steps {
            input('Do you want to proceed?')
        }
    }
    stage('Deploy to PROD env') {
        environment {
            HOSTS = 'prod'
        }
        steps {
            withCredentials([usernamePassword(credentialsId: 'ansible-credentials', passwordVariable: 'PASSWORD', usernameVariable: 'USER_NAME')]) {
                sh "ansible-playbook -i ${WORKSPACE}/ansible-setup/aws_ec2.yaml ${WORKSPACE}/deploy.yaml --extra-vars \"ansible_user=$USER_NAME ansible_password=$PASSWORD hosts=tag_Environment_$HOSTS workspace_path=$WORKSPACE\""
            }
         }
      }
   }
  post {
    always {
        echo 'Slack Notifications.'
        slackSend channel: '#cicd-project-alerts', //update and provide your channel name
        color: COLOR_MAP[currentBuild.currentResult],
        message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
    }
  }
}

//slackSend channel: '#mbandi-cloudformation-cicd', message: "Please find the pipeline status of the following ${env.JOB_NAME ${env.BUILD_NUMBER} ${env.BUILD_URL}"
