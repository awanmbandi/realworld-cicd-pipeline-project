# CI/CD Pipeline Project Using AWS Native SDLC Automation Tools
![CompleteAWSNativeCICDProject!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/cloudnative_optimized_cicd_pipeline_project_arch_v2.png)

**NOTE:** 
a) Navigate to a Region on AWS that has all the AWS Code services (CodeCommit, CodeBuild, CodeArtifact, CodeDeploy and CodePipeline)
b) You must Login as an IAM User before you can complete the below steps successfully (Login with a user that has Administrator Privileges)

## 1) Create a CodeCommit Project Repository
1.1) Navigate to CodeCommit to create a Project Repository
- Click on `Create Repository`
- Name your repository `AWS-Native-CICD-Pipeline-Project`
- Click `Create`
![CodeCommit!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.11.38%20PM.png)

1.2) Configure SSH Connection On Local MacOs or Windows With CodeCommit
- Follow the steps provided in the Runbook below
- Runbook: https://docs.google.com/document/d/1vDu6TBcIrh2NbUtv5eayur1Cdo3Z8X5YSZ9t58ItlXo/edit?usp=sharing

1.3) Download the Project Zip Code From The Below Repository Link
- Project Code: https://github.com/awanmbandi/realworld-cicd-pipeline-project/tree/aws-native-cicd-pipeline-project
- Unzip and Copy everything to the Code Commit Repository you just cloned
- Push the Code Upstream to Your CodeCommit Project Repository and Confirm you have everything in the Repository 
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
        - Attach Policy: `AdministratorAccess`
        - Click `Next` 
        - Role Name: `AWS-CodeDeploy-Deployment-Role`
        - Click `Create`

## 4) Create An S3 Bucket Where The Build Artifact Will Be Stored
- Navigate to Amazon S3
![S3!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.15.44%20PM.png)
- Click `Create Bucket` 
    - Name: `java-webapp-project-artifact-YOUR_ACCOUNT_ID`
    - Region: `Select Your working Region`
    - Click: `CREATE Bucket`


## 5) Sign Up For SonarCloud Account
A) Sign up for SonarCloud using this URL: https://sonarcloud.io or https://sonarsource.com or https://sonarcloud.io/login 
![SonarCloud!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-06%20at%2012.59.04%20PM.png)
- Click on `“FREE SONAR”`
- Click on `TRY SONARCLOUD`
- Sign in with your `“GitHub” Account`
- Click on `“Authorize SonarCloud”`
    - **NOTE:** Once you Authorize SonarCloud, It’ll take you directly to Dashboard (Similar to Traditional SonarQube Server Dashboard but this is cloud based)

B) We have to Generate a Token which CodeBuild will use during the Maven Execution
![SonarCloud2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-06%20at%201.03.17%20PM.png)
- Click on your Profile at the Top right and click on `My Account`
- Click on `Security`
- Generate Tokens (Provide a Name): `aws-native-cicd-pipeline-project`
- Copy the Token and Save it somewhere (on your NOTEPAD)

C) Click on the “+”  symbol at the Top Right
![SonarCloud3!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-06%20at%201.06.19%20PM.png)
- Click on Analyze new project
- Click on `create a project manually`.
    - Click on `Create another organization` 
        - Name (Must be Unique): `yourfirst-or-lastname-aws-devops`
        - Choose a plan: Select `“Free Plan”`
        - Click on `Create Organization`

D) Create a SonarCloud Project
- Click on `Create Project`
    - Project Key: aws-native-cicd-pipeline-project
    - Display name: aws-native-cicd-pipeline-project
    - Public/Private: Public  (because we’re using a free account)
    - Click “Set Up”
**NOTE** **Save your `Project Name` as well on Notepad, Save your `Organization name` and the Sonarcloud url (`https://sonarcloud.io`). Make sure your `Token` has been saved also.

## 6) Store Your SonarCloud Project Parameters In SSM Parameter Store
- Navigate to SSM
- Make sure you create the parameters in the same Region as the bucket (same for all project resources)
![ssmps!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-06%20at%201.18.36%20PM.png)
- **a)** Click on `Parameter Store`
  - Click on `Create Parameter`
  - Name: `Organization`
  - Value (String/Text): `provide your SnarCloud Org name`

- **b)** Click on `Parameter Store`
  - Name: `HOST`
  - Value (String/Text): https://sonarcloud.io

- **c)** Click on `Parameter Store`
  - Name: `Project`
  - Value (String/Text): `provide your SonaCloud Project name`

- **d)** Click on `Parameter Store`
  - Name: `sonartoken`
  - Value (String/Secure String): `provide your SonaCloud Project Token`
**NOTE:** Confirm that these same parameter names exist in your `sonacloud_buildspec.yaml` configuration.

## 7) Create The Project Build Job in CodeBuild
- Navigate To The AWS `CodeBuild` Service
![CodeBuild!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.17.16%20PM.png)
- Click on `Create Build Project` 
    - Project Name: `Java-Webapp-CB-Build-Job`
    - Source Provider: Select `AWS CodeCommit`
    - Repository: Select `AWS-Native-CICD-Pipeline-Project`
    - Branch: `master`
    - Operating System: `Ubuntu`
    - Runtime: `Standard`
    - Image: MUST USE  (`aws/codebuild/standard:5.0`) or else it’ll BREAK
    - Image version: Select `Always use the latest for this runtime version` 
    - Environment type: Select `Linux EC2`
    - Service Role: `Existing Service Role`
        - Role name: Select `AWS-CodeBuild-Admin-Role` 
    - Build Specifications: Pass `buildspecs/buildspec.yaml`
    - Artifacts:
        - Type: Select `Amazon S3`
        - Bucket name: Select your bucket `java-webapp-project-artifact-YOUR_ACCOUNT_ID`
        - Artifacts packaging: Select `Zip`
    - Logs
        - CloudWatch Logs: `Enable`
        - Group Name: `Java-Webapp-CodeBuild-Build-Logs`
        - Stream name: `Java-Webapp-CodeBuild-Build-Logs`
    - CLICK: Click `CREATE BUILD PROJECT`

## 8) Create The SonarCloud Code Analysis Job in CodeBuild
- Navigate To The AWS `CodeBuild` Service
![CodeBuild!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.17.16%20PM.png)
- Click on `Create Build Project` 
    - Project Name: `Java-Webapp-CB-SonarCloud-Job`
    - Source Provider: Select `AWS CodeCommit`
    - Repository: Select `AWS-Native-CICD-Pipeline-Project`
    - Branch: `master`
    - Operating System: `Ubuntu`
    - Runtime: `Standard`
    - Image: MUST USE  (`aws/codebuild/standard:5.0`) or else it’ll BREAK
    - Image version: Select `Always use the latest for this runtime version` 
    - Environment type: Select `Linux EC2`
    - Service Role: `Existing Service Role`
        - Role name: Select `AWS-CodeBuild-Admin-Role` 
    - Build Specifications: Pass `buildspecs/sonarcloud_buildspec.yaml`
    - Artifacts:
        - Type: Select `No Artifact`
    - Logs
        - CloudWatch Logs: `Enable`
        - Group Name: `Java-Webapp-CodeBuild-Build-Logs`
        - Stream name: `Java-Webapp-CodeBuild-SonarCloud-Logs`
    - CLICK: Click `CREATE BUILD PROJECT`

## 9) Create Staging Deployment Area/Environment
![EC2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.34.34%20PM.png)
- Navigate to EC2
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
            - NOTE: `If you do not have one, please go ahead and create before creating instance`
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

## 10) Create Production Deployment Area/Environment
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
            - NOTE: `If you do not have one, please go ahead and create before creating instance`
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

## 11) Create CodeDeploy Application
![CDApp!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%205.11.57%20PM.png)
- Navigate to CodeDeploy
    - Click on `Applications`
    - Click `Create Application`
        - Name: `Java-Webapp-CodeDeploy-Application`
        - Compute Platform: `EC2/On-premises`
        - Click `Create Application`

## 12) Create CodeDeploy Deployment Group
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
        - Deployment settings: Select `CodeDeployDefault.HalfAtATime`
        - Load balancer: Uncheck the box to `Disable`
        - Click `Create deployment group`

## 13) Create CodeDeploy Deployment Group
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
        - Deployment settings: Select `CodeDeployDefault.HalfAtATime`
        - Load balancer: Uncheck the box to `Disable`
        - Click `Create deployment group`

## 14) Create The CI/CD Automation Pipeline With CodePipeline
- Navigate to `CodePipeline`
![CP!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Pipeline.png)
- Click on `Create Pipeline`
    - Name: `AWS-Native-Java-Webapp-CICD-Pipeline-Automation`
    - Service role: `New service role`
        - Role name: `The name will populate automatically`
    - Allow AWS CodePipeline to create a service role so it can be used with this new pipeline: Chech box to `Enable`
    - Click `Next`
    - **SOURCE PROVIDER**
    - Source provider: Select `AWS CodeCommit`
        - Repository name: `AWS-Native-CICD-Pipeline-Project`
        - Branch name: `Master`
        - Change detection options: `Amazon CloudWatch Events (recommended)`
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
    - NOTE: Once you create the pipeline, it'll start Running Immediate. Just wait for all the various stages to complete
    - **NOTE2:** The Deployment Will Only Take Place In The Staging Environment (With Continuous Deployment)

## 15) Add The SAST Test Stage With SonarCloud
![EditPipeline!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/dsdsdsdsd.png)
- Click on `Edit` to add the following Pipeline Stages;
    - The `Testing Stage`
    - The `Manual Approval Stage`  
    - The `Prod Deployment Stage`
- Click on `Add stage`
- **NOTE:** Make sure to add this Stage in between the `Build` and `Desploy` Stage
![SASTStage!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-07%20at%201.33.14%20PM.png)
- Stage name: `SAST-Test-SonarCloud`
- Click on `Add action group`
  - Action name: `SAST-Test-SonarCloud`
  - Action provider: `AWS CodeBuild`
  - Region: `Select your project region`
  - Input artifact: `SourceArtifact`
  - Project name: `Select Your SonarCloud CodeBuild Job/Project`
  - Build type: `Single build`
  - Click `Done`

  - Click on `Done` again

## 16) Add The Manual Approval Stage (To Achieve Continuous Delivery To Production)
- Click on `Add stage`
![AddMA!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-07%20at%202.07.16%20PM.png)
- Stage name: `Manual-Approval`

- Click on `Add action group`
![AddMA!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-06%20at%202.00.26%20PM.png)
  - Action name: `Manual-Approval`
  - Action provider: `Manual approval`
  - Click `Done`

  - Click on `Done` again

## 17) Add The Deploy To Production Stage With CodeDeploy
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
  - Variable namespace: `DeployVariables`
  - Click `Done`

  - Click on `Done` to save changes
  - `SCROLL UP` and Click on `SAVE`
  - Click `SAVE`

### 18) RE-RUN YOUR PIPELINE & CONFIRM ALL 6 STAGES SUCCEEDS
- CLICK on `Release Changes`

### 19) REVIEW ALL JOBS (Whle The Pipeline Is Running)
- Go through the `CodeBuild JOB Output`
- Go through the `CodeDeploy JOB Output`
- Go through the `SonarCloud Project/Analysis`

### 20) CONFIRM THAT THE APPLICATION VALIDATE TEST PASSED
- Navigate to `CodeBuild`
    - Click on the Project 
    - Click on Build Phases and Confirm the Validate Script/Phase Was Successful

### ) TEST ACCESS TO THE APPLICATION
- Navigate to EC2 
    - Copy the Public IP Addresses of the Instances and Try Accessing the Application
    - URL: INSTANCE_PUBLIC_IP:8080/webapp

#### CONGRATULATIONS!! CONGRATULATIONS!! CONGRATULATIONS!!



