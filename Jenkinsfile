def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]
pipeline {
    agent any
    stages {
        // stage('Validate Prod Stack') {
        //     steps {
        //     sh "aws cloudformation validate-template --template-body file://ventura-network-infra.yaml --region 'us-east-1'"
        //     }
        // }
        stage('Template Cost Estimate') {
            steps {
            sh "aws cloudformation estimate-template-cost --template-body file://ventura-prod-env-infra.yaml --parameters file://ventura-infra-parametafile.json --region 'us-east-1'"
            }
        }
        // stage('Approval for Prod') {
        //     steps {
        //     input('Do you want to proceed considering cost?')
        //     }
        // }
        // stage('Create Prod Stack') {
        //     steps {
        //     sh "aws cloudformation create-stack --stack-name ventura-prod-infra-v1 --template-body file://ventura-prod-env-infra.yaml --parameters file://ventura-infra-parametafile.json --region 'us-east-1'"
        //     }
        // }
        stage('Update Prod Stack') {
            steps {
            sh "aws cloudformation update-stack --stack-name ventura-prod-infra-v1 --template-body file://ventura-prod-env-infra.yaml --parameters file://ventura-infra-parametafile.json --region 'us-east-1'"
            }
        }
        // stage('Slack Notification'){
        //    slackSend baseUrl: 'https://hooks.slack.com/services/',
        //    channel: '#jenkins-pipeline-demo',
        //    color: 'good', 
        //    message: 'Welcome to Jenkins, Slack!', 
        //    teamDomain: 'javahomecloud',
        //    tokenCredentialId: 'slack-demo'
        // }
    }
    post {
           always {
             echo 'Slack Notifications.'
             slackSend channel: '#mbandi-cloudformation-cicd', //update and provide your channel name
                color: COLOR_MAP[currentBuild.currentResult],
                message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
            }
        }
}