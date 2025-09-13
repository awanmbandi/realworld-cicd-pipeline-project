def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
    'UNSTABLE': 'danger'
]
pipeline {
    agent any
    stages {
        // Verifying setup
        stage('Confirm Tools Installations') {
            steps {
                sh 'git --version'
                sh 'terraform version'
            }
        }
        // IInitialize Terraform
        stage('Initialize Terraform Environment') {
            steps {
                sh 'terraform init'
            }
        }
        // Check terraform confugirations syntax
        stage('Validate Terraform Configurations') {
            steps {
                sh 'terraform validate'
            }
        }
        // Generating Execution Plan
        stage('Generate Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        // Deployment Apporval
        stage('Manual Approval') {
            steps {
                input 'Approval Infra Deployment'
            }
        }
        // Deploy Terraform Infrastructure
        stage('Deploy Infrastructure') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
    }
    post {
    always {
        echo 'Slack Notifications.'
        slackSend channel: '#ma-terraform-cicd-alerts', //update and provide your channel name
        color: COLOR_MAP[currentBuild.currentResult],
        message: "*${currentBuild.currentResult}:* Job Name '${env.JOB_NAME}' build ${env.BUILD_NUMBER} \n Build Timestamp: ${env.BUILD_TIMESTAMP} \n Project Workspace: ${env.WORKSPACE} \n More info at: ${env.BUILD_URL}"
    }
  }
}
