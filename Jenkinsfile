def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
    'UNSTABLE': 'danger'
]
pipeline {
    agent any
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'terraform-jenkins-pipeline-project', 
                url: 'https://github.com/awanmbandi/realworld-cicd-pipeline-project.git'
            }
        }
         stage('Verify Terraform Version') {
            steps {
                sh 'terraform --version'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'sudo terraform init'
               
            }
        }
        stage('Terraform Validate') {
            steps {
                sh 'sudo terraform validate'
               
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'sudo terraform plan'
               
            }
        }
        stage('Snyk Security Testing') {
            steps {
                // Run Snyk for security testing
                sh 'npx snyk test'
            }
        }
        stage('DAST Testing With Terratest') {
            steps {
                // Install and set up Go (if not already installed)
                // You may need to adjust the Go version based on your requirements
                sh 'wget -O go.tar.gz https://dl.google.com/go/go1.16.7.linux-amd64.tar.gz'
                sh 'tar -xvf go.tar.gz'
                sh 'sudo chown -R root:root ./go'
                sh 'sudo mv go /usr/local'
                sh 'echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc'
                sh 'source ~/.bashrc'

                // Clone your Terratest test repository
                git 'https://github.com/awanmbandi/realworld-cicd-pipeline-project.git'

                // Run Terratest tests
                sh 'cd realworld-cicd-pipeline-project'
                sh 'git checkout terraform-jenkins-pipeline-project'
                sh 'go test -v -timeout 30m'
            }
        }
        stage('Manual Approval') {
            steps {
                input 'Approval required for deployment'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'sudo terraform apply --auto-approve'
            }
        }
     }
     post { 
        always { 
            echo 'Slack Notifications.'
            slackSend channel: '#cicd-pipeline-project-alerts', //update and provide your channel name
            color: COLOR_MAP[currentBuild.currentResult],
            message: "*${currentBuild.currentResult}:* Job Name '${env.JOB_NAME}' build ${env.BUILD_NUMBER} \n Build Timestamp: ${env.BUILD_TIMESTAMP} \n Project Workspace: ${env.WORKSPACE} \n More info at: ${env.BUILD_URL}"
        }
    }
}