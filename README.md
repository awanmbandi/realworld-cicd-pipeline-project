## CI/CD Pipeline Automation Project Using AWS Native SDLC Tools
![CompleteAWSNativeCICDProject!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/v3.3_advanced_aws_native_cicd_project.png)

###### Project ToolBox 🧰
- [CodeCommit](https://aws.amazon.com/codecommit/) CodeCommit is a secure, highly scalable, fully managed source control service that hosts private Git repositories.
- [CodeBuild](https://aws.amazon.com/codebuild/) CodeBuild is a fully managed continuous integration service that compiles source code, runs tests, and produces ready-to-deploy software packages.
- [CodeArtifact](https://aws.amazon.com/codeartifact/) CodeArtifact allows you to store artifacts using popular package managers and build tools like Maven, Gradle, npm, Yarn, Twine, pip, NuGet, and SwiftPM.
- [CodeDeploy](https://aws.amazon.com/codedeploy/) CodeDeploy is a fully managed deployment service that automates software deployments to various compute services, such as EC2, ECS, Lambda, and on-premises.
- [CodePipeline](https://aws.amazon.com/codepipeline/) CodePipeline is a fully managed continuous delivery service that helps you automate your release pipelines for fast and reliable application and infrastructure updates.
- [Amazon S3](https://aws.amazon.com/s3/) Amazon S3 is an object storage service offering industry-leading scalability, data availability, security, and performance.
- [AWS ChatBot](https://aws.amazon.com/chatbot/) AWS Chatbot lets you monitor, troubleshoot, and operate your AWS environments natively from within your chat channels.
- [Slack](https://slack.com/) Slack is a communication platform designed for collaboration which can be leveraged to build and develop a very robust DevOps culture. Will be used for Continuous feedback loop.
- [EC2](https://aws.amazon.com/ec2/) EC2 allows users to rent virtual computers (EC2) to run their own workloads and applications.
- [CloudWatch Metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/working_with_metrics.html) Amazon CloudWatch can load all the metrics in your account (both AWS resource metrics and application metrics that you provide) for search, graphing, and alarms.
- [CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html) You can use CloudWatch Logs to monitor applications and systems using log data. 
- [Amazon SNS](https://aws.amazon.com/sns/) Amazon SNS is a Message Bus use to send notifications. It provides high-throughput, push-based, many-to-many messaging between distributed systems, microservices, and event-driven serverless applications. 
- [PMD SAST](https://docs.pmd-code.org/latest/) PMD (Programming Mistake Detector) is a static source code analyzer. It finds common programming flaws like unused variables, empty catch blocks, unnecessary object creation, and so forth. It’s mainly concerned with Java and Apex, but supports 16 other languages.

## Prerequisites
* Confirm that you have an active `AWS account`.
* Use a `Region` that offers the `CodeArtifact` service.
* Confirm you have `Git` configured on your local system.
* Confirm that you have a `GitHub` account.
* Confirm that you have at least one `IDE` software installed locally.

**NOTE:** 
* Navigate to a Region on AWS that has all the AWS Code services (CodeCommit, CodeBuild, CodeArtifact, CodeDeploy and CodePipeline)
* You must `Login` as an `IAM User` before you can complete the below steps successfully (Login with a user that has Administrator Privileges)

## 1) Create a CodeCommit Project Repository
1.1) Navigate to CodeCommit to create a Project Repository
- Click on `Create Repository`
- Name your repository `AWS-Native-CICD-Pipeline-Project`
- Click `Create`
![CodeCommit!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/dsbfdsbbfdf.png)

1.2) Configure SSH Connection On Local MacOs or Windows With CodeCommit
- Follow the steps provided in the Runbook below
- Runbook: https://docs.google.com/document/d/1vDu6TBcIrh2NbUtv5eayur1Cdo3Z8X5YSZ9t58ItlXo/edit?usp=sharing

1.3) Download the Project Zip Code From The Below Repository Link
- Project Code: https://github.com/awanmbandi/realworld-cicd-pipeline-project/tree/advanced-aws-native-cicd-project-one
- Unzip and Copy everything to the Code Commit Repository you just cloned
- Push the Code Upstream to Your CodeCommit Project Repository and Confirm you have everything in the Repository 
    - Add the code to git, commit and push it to your upstream branch "main or master"
    - Add the changes: `git add -A`
    - Commit changes: `git commit -m "adding project source code"`
    - Push to GitHub: `git push`
- NOTE: Use the same Git commands you have always used to Push code to GitHub

## 2) Create A CodeBuild IAM Profile/Role
- Create a CodeBuild Service Role in IAM with Administrator Privilege 
![IAM!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.20.44%20PM.png)
- Navigate to IAM
    - Click on `Roles`
    - Click on `Create Role`
    - Select `Service Role`
    - Search/Select `CodeBuild`
        - Click on `Next` 
        - Attach Policy: `AdministratorAccess`
        - Click `Next` 
        - Role Name: `AWS-CodeBuild-Admin-Role` 
        - Click `Create`

## 3) Create A CodeDeploy IAM Profile/Role
- Create a CodeBuild Service Role in IAM with Administrator Privilege 
![IAM!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.20.44%20PM.png)
- Navigate to IAM
    - Click on `Roles`
    - Click on `Create Role`
    - Select `Service Role`
    - Search/Select `CodeDeploy`
        - Click on `Next` 
        - Attach Policy: `AdministratorAccess` (Attach this after creating the Role)
        - Click `Next` 
        - Role Name: `AWS-CodeDeploy-Deployment-Role`
        - Click `Create`

## 3.2) Create An EC2 IAM Profile/Role
- Create an EC2 Service Role in IAM with Admin Privileges
- Navigate to IAM
![IAM!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.20.44%20PM.png)
    - Click on `Roles`
    - Click on `Create Role`
    - Select `Service Role`
    - Use Case: Select `EC2`
    - Click on `Next` 
    - Attach Policy: `AdministratorAccess` and `CloudWatchAgentServerPolicy`
    - Click `Next` 
    - Role Name: `AWS-EC2-Administrator-Role`
    - Click `Create`
    **NOTE:** There's no need to create if you already have one

## 4) Create An S3 Bucket Where The Build Artifact Will Be Stored
- Navigate to Amazon S3
![S3!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.15.44%20PM.png)
- Click `Create Bucket` 
    - Name: `java-webapp-project-artifact-YOUR_ACCOUNT_ID`
    - Region: `Select Your working Region`
        - **NOTE:** Confirm the Region selected is your working Region
    - Click: `CREATE Bucket`

## 5) Satic Application Security Testing (SAST) With PMD (Programming Mistake Detector)
* Navigate to the Folder name `pmd`
    * Confirm that you have the `pmd-ruleset.xml` config file with the `rulesets`
    ![PMDPOMConfig!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%2012.21.21%20PM.png)
* Also Confirm that the following command has been defined in your `pmd_buildspec.yml` in the `"buildspecs" folder`
```bash
cp ./pmd/pmd-ruleset.xml /root/.m2/pmd-ruleset.xml
```
* Verify that the destination path define above for the rulesets `/root/.m2/pmd-ruleset.xml` is specified in your maven `pom.xml` file as shown below.
![PMDPOMConfig!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%2012.11.51%20PM.png)

## 6) Configure Continuous Alerting/Feedback Loop With AWS ChatBot and Slack
### A) First We Need To Create an SNS Topic Which'll Act As Our Notification Bus
* Navigate to the AWS SNS Service
* Select your project Region
![SNS!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-17%20at%209.11.40%20AM.png)
  * Type: `Standard` 
  * Name: `ChatBot-Slack-Integration-Topic`
  * Display name: `ChatBot-Slack-Integration-Topic`
  * Click `Create topic`

### B) Click on the following Link to Join the Slack `Workspace` & Create a Channel
* Link: https://join.slack.com/t/jjtechtowerba-zuj7343/shared_invite/zt-24mgawshy-EhixQsRyVuCo8UD~AbhQYQ  
* Click on `Add channels` and select `Create a new channel` to create a Changel
    * Name: `YOUR-FIRST-&-LASTNAME-INITIAL-aws-native-cicd-project-alerts`
    ![Slack!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-17%20at%201.51.41%20AM.png)
    * Select `Private` and 
    * Click `Create` and Skip the option to add members to the channel

### C) Create an AWS ChatBot Client
* Navigate to `AWS ChatBot` Service
* Open the service and Select Slack
![ChatBot!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-17%20at%201.59.11%20AM.png)

![ChatBot!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/sasasasasasasasasasas.png)

* Configure Slack Integration In AWS ChatBot
![ChatBot!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-17%20at%208.49.32%20AM.png)
* Configuration name: `AWS-CICD-Pipeline-Project-ChatBot-Config`
* Channel type: `Private`
    * Channel ID: `Follow The Steps Below To Get The Chanel ID and Pass it Here`
    ![ChatBot!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-17%20at%208.59.19%20AM.png)
* Role settings: `Channel role`
* Channel role: `Create an IAM Role Using a Template`
* Role name: `ChatBot-Slack-Integration-Role`
* Policy templates: Make sure `Notification permissions` and `Resource Explorer Permissions` roles are selected
* Policy name: `ReadOnlyAccess`
* SNS topics
    * Region 1: Select `Your Working/Topic Region`
    * Topics 1: Select `Your Topic`, which should be `ChatBot-Slack-Integration-Topic`

* Click on `Configure`

### D) Add The AWS ChatBot App To Your Slack Channel
* Navigate to `Slack`
* Right Click on your Channel Name and select `view chanel details`
![SlackAWSChatBot!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-17%20at%201.58.33%20PM.png)
* Add the `AWS ChatBot` App to your Pipeline Channel
![SlackAWSChatBot!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-17%20at%202.01.29%20PM.png)

## 7) Create & Configure CodeArtifact Repository to Store and Manage All Application Maven Dependencies.
### A) Create CodeArtifact Project Repository
* Navigate to AWS `CodeArtifact` 
* Click on `Repository`
    * Click `Create Repositoy`
![CodeArtifact!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-08%20at%2011.55.53%20PM.png)
  * Repository Name: `java-webapp-maven-repo`
  * Public Upstream Repository: Select `maven-central-store`
  * Click on `Next`
    * AWS Account: Select `This AWS Account`
    * Domain Name: `java-webapp-maven-repo`
    * Click on `Next`
    * Click `Create Repository`
  * **NOTE:** Verify and Confirm both the `Repository` and the `Repository Domain` were created successfully
![CodeArtifact!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-09%20at%2012.13.04%20AM.png)

### B) Configure Your CodeArtifact Project Repository With Maven POM.xml and Settings.xml
  * Click on `Repositories` if you’ve not already
    * Click on `maven-central-store`
    * Click on `View Connection Instructions`
    ![CodeArtifact!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-09%20at%2012.45.21%20AM.png)
      * **Step 1:** Choose a package manager client: "Select (on the drop down):" `mvn`
      * **Step 3:** **COPY** and Run The `export` Command on your Local Terminal where `awscli` is installed
        * *NOTE:NOTE:NOTE:NOTE!!* 
        - The command will look like this 
        - BUT COPY YOUR OWN
        - Make sure your AWSCLI is configured (with a user with "Admin Priviledges")
        ```bash
        export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain java-webapp-maven-repo --domain-owner 213424289791 --region us-east-1 --query authorizationToken --output text`
        ```
        - Also RUN: `echo $CODEARTIFACT_AUTH_TOKEN`
        * *NOTE:NOTE:*
            - Copy the `CODEARTIFACT_AUTH_TOKEN` Encrypted Credential and `SAVE` on your `NOTEPAD/Somewhere`
            - We’re going to store this Token in SSM Parameter Store from where our CodeBuild Job is going pick it up
        ![CodeArtifact!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-09%20at%2012.59.21%20AM.png)

### B.1) Update the Settings.xml File With CodeArtifact Repository Configurations
  * Still on `“View Connection Instructions”` in `maven-central-store`
  ![CodeArtifact!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-09%20at%2012.51.13%20AM.png)
  * Under Step 5: 
    - `COPY` the Repository `id` and Paste it in the `settings.xml` file on `line 29` at the time of this
    - `COPY` the Repository `url` and Paste on `Line 18` and `Line 30` in the `settings.xml` at the time of this
    - `SAVE` the changes made in the file
    ![CodeArtifact!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%201.14.26%20PM.png)

### B.2) Update the POM.xml File With CodeArtifact Repository Configurations
  * Still on `“View Connection Instructions”` in `maven-central-store`
  ![CodeArtifact!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-09%20at%2012.51.13%20AM.png)
  * Under Step 5: 
    - `COPY` the Repository `id` and Paste it in the `POM.xml` file on `Line 32` at the time of this
    - `COPY` the Repository `url` and Paste on `Line 33` in the `POM.xml` at the time of this
    - `SAVE` the changes made in the file
    - `COMMIT` the changes and `PUSH` to UpStream to `CodeCommit`
    ![CodeArtifact!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%201.19.35%20PM.png)

## 8) Store Your AWS CodeArtifact Repository Access Token In SSM Parameter Store
- Navigate to SSM
- **NOTE!!** Make sure you create the parameters in the same Region as the bucket (same for all project resources)
![ssmps!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-06%20at%201.18.36%20PM.png)
- **a)** Click on `Parameter Store`
  - Click on `Create Parameter`
  - Name: `CODEARTIFACT_AUTH_TOKEN`
  - Type: Select `Secure/String`
  - Value: `provide your CodeArtifact Token` the one you copied when you ran the command...
  ```bash
  echo $CODEARTIFACT_AUTH_TOKEN
  ```
  - Click `Create`

![ssmps!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%2012.51.13%20PM.png)
**NOTE:** Confirm that this same parameter names exist in your `pmd_buildspec.yaml` configuration.

## 9) Create The Project Build Job in CodeBuild
- Navigate To The AWS `CodeBuild` Service
![CodeBuild!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.17.16%20PM.png)
- Click on `Create Build Project` 
    - Project Name: `Java-Webapp-CB-Build-Job`
    - Source Provider: Select `AWS CodeCommit`
    - Repository: Select `AWS-Native-CICD-Pipeline-Project`
    - Branch: `master`
    - Operating System: `Amazon Linux`
    - Runtime: `Standard`
    - Image: MUST USE  (`aws/codebuild/amazonlinux2-x86_64-standard:5.0`) or latest
    - Image version: Select `Always use the latest for this runtime version` 
    - Environment type: Select `Linux EC2`
    - Service Role: `Existing Service Role`
        - Role name: Select `AWS-CodeBuild-Admin-Role` 
        - Allow AWS CodeBuild to modify this service role so it can be used with this build project: `Disable/Uncheck`
    - Build Specifications: Select `Use a buildspec file`
        - Provide this Path `buildspecs/buildspec.yml`
    - Artifacts:
        - Type: Select `Amazon S3`
        - Bucket name: Select your bucket `java-webapp-project-artifact-YOUR_ACCOUNT_ID`
        - Name: `CodeBuild-Build-Artifact`
        - Artifacts packaging: Select `Zip`
    - Logs
        - CloudWatch Logs: `Enable`
        - Group Name: `Java-Webapp-CodeBuild-Project-Logs`
        - Stream name: `Java-Webapp-CodeBuild-Build-Logs`
    - CLICK: Click `CREATE BUILD PROJECT`

## 10) Create The PMD Code Analysis Job in CodeBuild
- Navigate To The AWS `CodeBuild` Service
![CodeBuild!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/patisdsd_dah_sada.png)
- Click on `Create Build Project` 
    - Project Name: `Java-Webapp-CB-PMD-Job`
    - Source Provider: Select `AWS CodeCommit`
    - Repository: Select `AWS-Native-CICD-Pipeline-Project`
    - Branch: `master`
    - Operating System: `Amazon Linux`
    - Runtime: `Standard`
    - Image: MUST USE  (`aws/codebuild/amazonlinux2-x86_64-standard:5.0`) or latest
    - Image version: Select `Always use the latest for this runtime version` 
    - Environment type: Select `Linux EC2`
    - Service Role: `Existing Service Role`
        - Role name: Select `AWS-CodeBuild-Admin-Role` 
        - Allow AWS CodeBuild to modify this service role so it can be used with this build project: `Disable/Uncheck`
    - Build Specifications: Select `Use a buildspec file`
        - Pass `buildspecs/pmd_buildspec.yml`
    - Artifacts:
        - Type: Select `Amazon S3`
        - Bucket name: Select your bucket `java-webapp-project-artifact-YOUR_ACCOUNT_ID`
        - Name: `PMD-Test-Results`
        - Artifacts packaging: Select `Zip`
    - Logs
        - CloudWatch Logs: `Enable`
        - Group Name: `Java-Webapp-CodeBuild-Project-Logs`
        - Stream name: `Java-Webapp-CodeBuild-PMD-Logs`
    - CLICK: Click `CREATE BUILD PROJECT`
![CodeBuild!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%201.45.44%20PM.png)

## 11) Create Staging Deployment Area/Environment
- Navigate to EC2
![EC2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.34.34%20PM.png)
- Click `Launch Instances`
    - Name: `Stage-Env`
    - Click `Add additional tags`
        - Click `Add new tag`
            - Key: `Env`
            - Value: `Stage`
    - Number of Instances: `1`
    - AMI: `Amazon Linux 2 (HVM)`
    - Instance type: `t2.micro`
    - Key pair: `Select an existing Key` or `Create New`
    - Network Settings: 
        - VPC: `Default` or a network that has Internet access
        - Auto-assign public IP: `Enable`
        - Firewall (security groups): Open the following Ports
            - Name: `Tomcat-App-SG`
            - Description: `Tomcat-App-SG`
            - Open Port `8080` to `0.0.0.0/0`
            - Open Port `22` to eith your Network or Internet
    - Edvance Details:
        - IAM instance profile: `Select an EC2 Admin Role`
            - NOTE: `If you do not have one, please go ahead and create before creating the instance`
            - NOTE: `If Not Yours Will Break`
        - User data: 
        ```bash
        #!/bin/bash
        sudo yum update
        sudo yum install ruby -y
        sudo yum install wget -y
        cd /home/ec2-user
        wget https://aws-codedeploy-us-west-2.s3.us-west-2.amazonaws.com/latest/install
        chmod +x ./install
        sudo ./install auto
        sudo service codedeploy-agent status
        ```

        - Click `Launch Instance`

## 12) Create Production Deployment Area/Environment
![EC2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.34.34%20PM.png)
- Navigate to EC2
- Click `Launch Instances`
    - Name: `Prod-Env`
    - Click `Add additional tags`
        - Click `Add new tag`
            - Key: `Env`
            - Value: `Prod`
    - Number of Instances: `1`
    - AMI: `Amazon Linux 2 (HVM)`
    - Instance type: `t2.micro`
    - Key pair: `Select an existing Key` or `Create New`
    - Network Settings: 
        - VPC: `Default` or a network that has Internet access
        - Auto-assign public IP: `Enable`
        - Firewall (security groups): Open the following Ports
            - Click on `Select existing security group`
            - Security group: Select `Tomcat-App-SG`
    - Edvance Details:
        - IAM instance profile: Select an EC2 Admin Role
            - NOTE: `If you do not have one, please go ahead and create before creating the instance`
            - NOTE: `If Not Yours Will Break`
        - User data: 
        ```bash
        #!/bin/bash
        sudo yum update
        sudo yum install ruby -y
        sudo yum install wget -y
        cd /home/ec2-user
        wget https://aws-codedeploy-us-west-2.s3.us-west-2.amazonaws.com/latest/install
        chmod +x ./install
        sudo ./install auto
        sudo service codedeploy-agent status
        ```

        - Click `Launch Instance`
#### 12.1) Confirm that you have both the Stage and Prod Environments
![Stage&ProdInstances!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-09%20at%2010.25.51%20AM.png)

## 13) Create CodeDeploy Application
- Navigate to CodeDeploy
![CDApp!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%205.11.57%20PM.png)
- Click on `Applications`
    - Click `Create Application`
        - Name: `Java-Webapp-CodeDeploy-Application`
        - Compute Platform: `EC2/On-premises`
        - Click `Create Application`

## 14) Create A CodeDeploy Deployment Group To Deploy Staging Env
- Navigate to CodeDeploy
![CDApp!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.26.42%20PM.png)
- Click on `Applications`
    - Click on `Java-Webapp-CodeDeploy-Application`
    - Click on `Create deployment group`
        - Deployment group name: `Java-Webapp-CodeDeploy-Stage-DG`
        - Service role: `AWS-CodeDeploy-Deployment-Role`
        - Deployment type: Select `In-place`
        - Environment configuration: Select `Amazon EC2 instances`
            - Key: `Env`
            - Value: `Stage`
        - Agent configuration with AWS Systems Manager: `Now and schedule updates`
            - Basic Scheduler
        - Deployment settings: Select `CodeDeployDefault.AllAtOnce`
            - **NOTE:** CONFIRM THAT YOU SELECTED `CodeDeployDefault.AllAtOnce` IF Not, yours will break.
        - Load balancer: Uncheck the box to `Disable`
        - Click `Create deployment group`

## 15) Create A CodeDeploy Deployment Group For The Production Env
- Navigate to CodeDeploy
![CDApp!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.26.42%20PM.png)
- Click on `Applications`
    - Click on `Java-Webapp-CodeDeploy-Application`
    - Click on `Create deployment group`
        - Deployment group name: `Java-Webapp-CodeDeploy-Prod-DG`
        - Service role: `AWS-CodeDeploy-Deployment-Role`
        - Deployment type: Select `In-place`
        - Environment configuration: Select `Amazon EC2 instances`
            - Key: `Env`
            - Value: `Prod`
        - Agent configuration with AWS Systems Manager: `Now and schedule updates`
            - Basic Scheduler
        - Deployment settings: Select `CodeDeployDefault.AllAtOnce`
            - **NOTE:** CONFIRM THAT YOU SELECTED `CodeDeployDefault.AllAtOnce` IF Not, yours will break.
        - Load balancer: Uncheck the box to `Disable`
        - Click `Create deployment group`

## 16) Create The CI/CD Automation Pipeline With CodePipeline
- Navigate to `CodePipeline`
![CP!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Pipeline.png)
- Click on `Create Pipeline`
    - Name: `AWS-Native-Java-Webapp-CICD-Pipeline-Automation`
    - Pipeline type: `V1`
    - Execution mode: `Superseded`
    - Service role: `New service role`
        - Role name: `The name will populate automatically`
    - Allow AWS CodePipeline to create a service role so it can be used with this new pipeline: Chech box to `Enable`
        - Click `Next`
    - **SOURCE PROVIDER**
    - Source provider: Select `AWS CodeCommit`
        - Repository name: `AWS-Native-CICD-Pipeline-Project`
        - Branch name: `Master`
        - Change detection options: Select `Amazon CloudWatch Events (recommended)`
        - Output artifact format: `CodePipeline default`
        - Click `Next`
    - **BUILD PROVIDER**
    - Build provider: `AWS CodeBuild`
        - Region: `Your region will populate`
        - Project name: `Java-Webapp-CB-Build-Job`
        - Build type: `Single build`
        - Click `Next`
    - **DEPLOY PROVIDER**
    - Deploy provider: `AWS CodeDeploy`
        - Region: `Your region will populate`
        - Application name: `Java-Webapp-CodeDeploy-Application`
        - Deployment group: `Java-Webapp-CodeDeploy-Stage-DG`
        - Click `Next`
    
    - Click `CREATE PIPELINE`
    - **NOTE:** Once you create the pipeline, it'll start Running Immediate. CLICK ON `STOP EXECUTION`
    ()

## 17) Add The SAST Test Stage With PMD Test Stage
![EditPipeline!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/dsdsdsdsd.png)
- Click on `Edit` to add the following Pipeline Stages;
    - The `Testing Stage`
    - The `Manual Approval Stage`  
    - The `Prod Deployment Stage`
- Click on `Add stage`
- **NOTE:** Make sure to add this Stage in between the `Build` and `Desploy` Stage
![SASTStage!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%202.03.54%20PM.png)
- Stage name: `SAST-Test-PMD`
- Click on `Add action group`
  - Action name: `SAST-Test-PMD`
  - Action provider: `AWS CodeBuild`
  - Region: `Select your project region`
  - Input artifact: `SourceArtifact`
  - Project name: `Select Your PMD CodeBuild Job/Project`
  - Build type: `Single build`
  - Click `Done`

  - Click on `Done` again

## 18) Add The Manual Approval Stage (To Achieve Continuous Delivery To Production)
- Click on `Add stage`
![AddMA!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%202.07.58%20PM.png)
- Stage name: `Manual-Approval`

- Click on `Add action group`
![AddMA!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-06%20at%202.00.26%20PM.png)
  - Action name: `Manual-Approval`
  - Action provider: `Manual approval`
  - Click `Done`

  - Click on `Done` again

## 19) Add The Deploy To Production Stage With CodeDeploy
- Click on `Add stage`
![DeployProd!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-06%20at%202.10.51%20PM.png)
- Stage name: `Deploy-Prod`
- Click on `Add action group`
  - Action name: `Deploy-Prod`
  - Action provider: `AWS CodeDeploy`
  - Region: `Select your project region`
  - Input artifact: `BuildArtifact`
  - Application name: `Java-Webapp-CodeDeploy-Application`
  - Deployment group: `Java-Webapp-CodeDeploy-Prod-DG`
  - Click `Done`

  - Click on `Done` to save changes
  - `SCROLL UP` and Click on `SAVE`
  - Click `SAVE`

## 20) Integrate The AWS ChatBot/Slack Configuration With Your Pipeline
* Confirm that you've added all pipeline Stages
* Click on `Notify`
    * Click on `Create notification rule`
![PipelineNotifier!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-17%20at%209.46.41%20AM.png)
* Name: `Slack-Notification`
* Detail type: `Basic`
* Events that trigger notifications: `Select Important Events`
![EditPipeline!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-17%20at%2010.22.24%20AM.png)
* Targets
    * Choose target type: `AWS ChatBot Slack`
    * Choose target: Select your ChatBot Config `AWS-CICD-Pipeline-Project-ChatBot-Config`
    * Click `SUBMIT`

### 21) RE-RUN YOUR PIPELINE and CONFIRM THE APP IS AVAILABLE IN STAGING ENV BEFORE APPROVING PRODUCTION
- Click on `Pipeline` on your left
- CLICK on `Release Change`
![ReRunPipeline!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-09%20at%2012.45.43%20PM.png)

#### 22) Slack Notification With AWS ChatBot
* Check Your Pipeline Slack Channel For Updates Regarding Your Pipeline
![ReRunPipeline!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-17%20at%2010.29.11%20AM.png)

#### 23) Test To The Application Running In The Staging Environment
* Navigate to EC2 
* Copy the Public IP Addresses of the `Stage Instance` and Try Accessing the Application
* URL: http://INSTANCE_PUBLIC_IP:8080/login 
![WebApp!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%203.04.28%20PM.png)

### 24) REVIEW AND APPROVE PRODUCTION DEPLOYMENT
- Once you Confirm that The Application is working as Expected...
- Click on `Review` 
- Then `APPROVE` to Deploy to the `Prod Environment`
![SuccessPipeResults!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%203.30.14%20PM.png)
![SuccessPipeResults!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%203.31.11%20PM.png)
![SuccessPipeResults!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%203.31.33%20PM.png)

### 25) REVIEW ALL JOBS (Whle The Pipeline Is Running)
- Go through the *`CodeArtifact Downloaded Dependencies`*
- Go through the *`CodeBuild Build & Test Job Outputs`*
- Go through the *`CodeDeploy Stage & Prod Prod Deployment Results`*
- Go through the *`PMD Project/Analysis` etc*
    - *Download the Reports From s3. The CodePipeline Bucket >> BuildArtifact*
    - *Navigate to server --> target --> site --> Click on the `pmd.html` Report*

#### 25A) CodeArtifact Maven Project Repository
i) CodeArtifact `maven-central-store` (These Dependencies Where All Downloaded From `Maven Central` and Stored Here)
![CodeArtifact!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-09%20at%203.35.20%20AM.png)

ii) CodeBuild Project Logs (Build and Test Jobs)
![CodeArtifact!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-09%20at%2012.58.45%20PM.png)

#### 25B) Continuous Pipeline Notification With AWS ChatBot & Slack
![ChatBotSlack!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-17%20at%2010.29.11%20AM.png)

#### 25C) CodeBuild Build Job Results
![CodeBuildBuildJob!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-09%20at%203.12.18%20AM.png)

#### 25D) CodeBuild PMD SAST Job Results
![CodeBuildSASTJob!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%203.16.47%20PM.png)

#### 25E) PMD SAST Test Results
![CodeBuildSASTtestResults!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%203.20.27%20PM.png)

#### 25F) CodeDeploy Deployment Results (Stage&Prod)
- Navigate to `CodeDeploy`
![CodeDeploy!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-09%20at%203.28.15%20AM.png)

### 26) CONFIRM THAT THE APPLICATION VALIDATE TEST PASSED
![CodeDeploy!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-09%20at%209.26.28%20AM.png)

### 29) TEST ACCESS TO THE APPLICATION
* Navigate to EC2 
* Copy the Public IP Addresses of the Instances and Try Accessing the Application
* URL: http://INSTANCE_PUBLIC_IP:8080/login 
![WebApp!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%203.25.08%20PM.png)

### 30) CONFIGURE THE CLOUDWATCH AGENT (METRIC AND LOG COLLECTOR)
#### 30A) Install the CloudWatch Agent Using SSM (Run Command)
- Navigate to the `SSM Service` in your `Working Region`
- Configuration Options
    - Amazon CloudWatch
![SSMCloudWatchInstall!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/acdac.png)
- Navigate to `Run Command`
    - Click on `Run Command`
    - Command Document: Select `AWS-ConfigureAWSPackage`
    - Action: Select `Install`
    - Name: `AmazonCloudWatchAgent`  *(Make sure to provide this specific name)*
    - Target selection: Select `Choose instances manually`
        - Select your `Stage-Env` and `Prod-Env` instances
    - Output Options
        - Write command output to an Amazon S3 bucket: `Uncheck/Disable`
    - Click on `RUN`
![SSMCloudWatchInstall!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/SDVSS.png)

#### 30B) Configure the CloudWatch Agent (Metric and Log Collector (Collectd))
- Login/SSH into both the `Stage` and `Prod` VMs
- RUN the following commands on both the `Stage-Env` and `Prod-Env` instances/vms
```bash
## Install the Collectd
sudo amazon-linux-extras install collectd -y

## Execute/Run the CloudWatch Config Wizard
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
```
- CloudWatch Agent Configuration Interactive Wizard
![CWA1!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/cw1.png)
![CWA2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/cw2.png)
![CWA3!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/cw3.png)
![CWA4!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/cw4.png)
![CWA5!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/cw5.png)
![CWA6!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/cw6.png)

```bash
## Validate the CloudWatch Agent Configuration
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s

## Start the CloudWatch Agent
sudo systemctl start amazon-cloudwatch-agent

## Check the CloudWatch Agent status
sudo systemctl status amazon-cloudwatch-agent
```

#### 30C) Confirm That The CloudWatch Unified Log/Metric Agent Is Working
#### CloudWatch Metrics (CPU, RAM, Memory, Storage and Network)
- Navigate to the `CloudWatch Service`
- Click on `Metrics` and `All metrics`
![CWA!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/aAAASdssd.png)

#### CloudWatch Logs (Application Logs)
- Navigate to the `CloudWatch Service`
- Click on `Logs` and `Log groups`
![CWA!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/sdfsvdfs.png)
![CWA!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/csdcsdsc.png)

### 31) TEST ACCESS TO THE APPLICATION
* Navigate to EC2 
* Copy the Public IP Addresses of the Instances and Try Accessing the Application
* URL: http://INSTANCE_PUBLIC_IP:8080/login 
![WebApp!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-16%20at%203.25.08%20PM.png)

## 👨‍💻😃 CONGRATULATIONS TEAM!! CONGRATULATIONS TEAM!! 👨‍💻😃



