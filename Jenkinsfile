def COLOR_MAP = [
    'SUCCESS':'good',
    'FAILURE':'danger'
]

pipeline{
    agent any
    tools{
        jdk 'JDK'
        maven 'Maven'
    }
    stages{
        stage('Git Checkout'){
            steps{
                git branch: 'ci-jenkins', url: 'https://github.com/Abionaraji/personally-project.git'
            }
        }
        stage('Build Maven'){
            steps{
                sh 'mvn clean install'
            }
        }
        stage('Test Unit'){
            steps{
                sh 'mvn test'
            }
            post {
                success {
                    slackSend channel: '#ci-work',
                    color: 'good',
                    message: "UNIT TEST IS SUCCESS"
                }
                failure {
                    slackSend channel: '#ci-work',
                    color: 'danger',
                    message: "UNIT TEST IS FAILED"
                }
            }
        }
        stage('Checkstyle Analysis'){
            steps{
                sh 'mvn checkstyle:checkstyle'
            }
        }
        stage('Intergrated Testing'){
            steps{
                sh 'mvn verify -DiskipUnitTest'
            }
            post {
                success {
                    slackSend channel: '#ci-work',
                    color: 'good',
                    message: "INTEGRATED TESTING IS SUCCESS"
                }
                failure {
                    slackSend channel: '#ci-work',
                    color: 'danger',
                    message: "INTEGRATED TESTING IS FAILED"
                }
            }
        }
        stage('Sonarqube Analysis'){
            steps{
                withSonarQubeEnv(installationName: 'SonarQube', credentialsId: 'jenkins-sonar') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Quality Gate Status'){
            steps{
                waitForQualityGate abortPipeline: true, credentialsId: 'jenkins-sonar'
            }
        }
        stage('Upload War into Nexus'){
            steps{
                nexusArtifactUploader artifacts: 
                [
                    [
                        artifactId: 'spring-web', 
                        classifier: '', 
                        file: 'target/vprofile-v2.war', 
                        type: 'war'
                        ]
                    ], 
                    credentialsId: 'nexus-jenkis', 
                    groupId: 'production', 
                    nexusUrl: '54.172.243.16:8081', 
                    nexusVersion: 'nexus3', 
                    protocol: 'http', 
                    repository: 'vpro-maven', 
                    version: 'v2'
            }
        }
    }
    post {
        always{
            echo 'slack notifications'
            slackSend channel: '#ci-work',
            color: COLOR_MAP[currentBuild.currentResult],
            message: "*${currentBuild.currentResult}:* Job name ${env.JOB_NAME} build ${env.BUILD_NUMBER} time ${env.BUILD_TIMESTAMP} \n More info at: ${BUILD_URL}"
        }
    }
}
