# Continuous Development Project
![DevelopmentEnvironemntSetupProject!](https://lucid.app/publicSegments/view/3fac4adb-6bb8-444e-a5a9-7e86a8c77c67/image.png)

###### Project ToolBox 🧰
- [Git](https://git-scm.com/) Git will be used to manage our application source code.
- [Github](https://github.com/) Github is a free and open source distributed VCS designed to handle everything from small to very large projects with speed and efficiency
- [Maven](https://maven.apache.org/) Maven will be used for the application packaging and building including running unit test cases
- [SonarQube](https://docs.sonarqube.org/) SonarQube Catches bugs and vulnerabilities in your app, with thousands of automated Static Code Analysis rules.
- [Nexus](https://www.sonatype.com/) Nexus Manage Binaries and build artifacts across your software supply chain
- [EC2](https://aws.amazon.com/ec2/) EC2 allows users to rent virtual computers (EC2) to run their own workloads and applications.

## Configure Environments
1) Create a GitHub Repository
    - Navigate to https://github.com
    - Click on Repositories
    - Click on `Create` to Create a Repository
     - Repository Name: `jenkins-maven-sonarqube-nexus-project`
     - Click on `Create`
     - Download the Project Zip from https://github.com/awanmbandi/realworld-cicd-pipeline-project/tree/maven-sonarqube-nexus-jenkins-p1
     - Unzip and Push the code to the Repository you just provisioned

2) SonarQube
    - Create an Create an Ubuntu 20.04 VM instance and call it "SonarQube"
    - Instance type: `t2.medium`
    - Security Group (Open): 9000 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-sonarqube-nexus-jenkins-p1/tools/sonarqube-install.sh
    - Launch Instance

3) Jenkins/Maven
    - Create an Amazon Linux 2 VM instance and call it "Jenkins-Maven"
    - Instance type: `t2.medium`
    - Security Group (Open): 8080 and 22 to 0.0.0.0/0 or Your-IP
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-sonarqube-nexus-jenkins-p1/tools/jenkins-maven-install.sh
    - Launch Instance

4) Nexus
    - Create an Amazon Linux 2 VM instance and call it "Nexus"
    - Instance type: `t2.medium`
    - Security Group (Open): 8081 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-sonarqube-nexus-jenkins-p1/tools/nexus-install.sh
    - Launch Instance

## Configure Nexus Repository
Series of tutorial code snippets for use
#Maven publish tutorial steps
Publishing artifact to Nexus snapshot and release repo using maven.
