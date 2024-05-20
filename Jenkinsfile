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
                sh 'npm snyk --version'
                sh 'checkov --version'
            }
        }
        // Providing Snyk Access
        stage('Authenticate Snyk') {
            steps {
                withCredentials([string(credentialsId: 'snyk-api-token', variable: 'SNYK_TOKEN')]) {
                    sh "snyk auth $SNYK_TOKEN"
                }
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
                sh 'terraform plan --var-file=prod.tfvars'
            }
        }
        // Snyk Infrastructure Automation Test
        stage('Snyk Security Test') {
            steps {
                sh 'snyk iac test .'
            }
        }
        // Checkov Infrastructure Automation Test
        stage('Checkov scan') {
            steps {
                sh 'checkov -d .'
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
                sh 'terraform apply --var-file=prod.tfvars --auto-approve'
            }
        }
        // Destroy Environment
        // stage('Terraform Destroy') {
        //     steps {
        //         sh 'terraform destroy --var-file=prod.tfvars --auto-approve'
        //     }
        // }
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
