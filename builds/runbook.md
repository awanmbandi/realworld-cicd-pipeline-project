# CI/CD Pipeline Project Using AWS Native SDLC Automation Tools

**NOTE:** 
a) Navigate to a Region on AWS that has all the AWS Code services (CodeCommit, CodeBuild, CodeArtifact, CodeDeploy and CodePipeline)
b) You must Login as an IAM User before you can complete the below steps successfully (Login with a user that has Administrator Privileges)

**Pre-requisites**

## 1) Create a CodeCommit Project Repository
1.1) Navigate to CodeCommit to create a Project Repository
    - Click on `Create Repository`
    - Name your repository `AWS-Native-CICD-Pipeline-Project`
    - Click `Create`

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
- Click `Create Bucket` 
    - Name: `java-webapp-project-artifact-YOUR_ACCOUNT_ID`
    - Region: `Select Your working Region`
    - Click: `CREATE Bucket`

## 5) Create The Project Build Job in CodeBuild
- Navigate To The AWS `CodeBuild` Service
- Click on `Create Project` 
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
    - Build Specifications: Select `Use a buildspec file`
    - Artifacts:
        - Type: Select `Amazon S3`
        - Bucket name: Select your bucket `java-webapp-project-artifact-YOUR_ACCOUNT_ID`
        - Artifacts packaging: Select `Zip`
    - Logs
        - CloudWatch Logs: `Enable`
        - Group Name: `Java-Webapp-CodeBuild-Build-Logs`
        - Stream name: `Java-Webapp-CodeBuild-Build-Logs`
    - CLICK: Click `CREATE BUILD PROJECT`

## 6) Create Deployment Area/Environment
- Navigate to EC2
- Click `Launch Instances`
    - Name: `Prod-Env`
    - Click `Add additional tags`
        - Click `Add new tag`
            - Key: `Env`
            - Value: `Prod`
    - Number of Instances: `2`
    - AMI: `Amazon Linux 2 (HVM)`
    - Instance type: `t2.micro`
    - Key pair: `Select an existing Key` or `Create New`
    - Network Settings: 
        - VPC: `Default` or a network that has Internet access
        - Auto-assign public IP: `Enable`
        - Firewall (security groups): Open the following Ports
            - Name: `Tomcat-SG`
            - Description: `Tomcat-SG`
            - Open Port `8080` to `0.0.0.0/0`
            - Open Port `22` to eith your Network or Internet
    - Edvance Details:
        - IAM instance profile: Select an EC2 Admin Role
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

## 7) Create CodeDeploy Application
- Navigate to CodeDeploy
    - Click on `Applications`
    - Click `Create Application`
        - Name: `Java-Webapp-CodeDeploy-Application`
        - Compute Platform: `EC2/On-premises`
        - Click `Create Application`

## 8) Create CodeDeploy Deployment Group
- Navigate to CodeDeploy
- Click on `Applications`
    - Click on `Java-Webapp-CodeDeploy-Application`
    - Click on `Create deployment group`
        - Deployment group name: `Java-Webapp-CodeDeploy-DG`
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

## 9) Create The CI/CD Automation Pipeline With CodePipeline
- Navigate to `CodePipeline`
- Click on `Create Pipeline`
    - Name: `AWS-Native-Java-Webapp-CICD-Pipeline-Automation`
    - Service role: `New service role`
        - Role name: `The name will populate automatically`
    - Allow AWS CodePipeline to create a service role so it can be used with this new pipeline: Chech box to `Enable`
    - Click `Next`
    **SOURCE PROVIDER**
    - Source provider: Select `AWS CodeCommit`
        - Repository name: `AWS-Native-CICD-Pipeline-Project`
        - Branch name: `Master`
        - Change detection options: `Amazon CloudWatch Events (recommended)`
        - Output artifact format: `CodePipeline default`
        - Click `Next`
    **BUILD PROVIDER**
    - Build provider: `AWS CodeBuild`
        - Region: `Your region will populate`
        - Project name: `Java-Webapp-CB-Build-Job`
        - Build type: `Single build`
        - Click `Next`
    **DEPLOY PROVIDER**
    - Deploy provider: `AWS CodeDeploy`
        - Region: `Your region will populate`
        - Application name: `Java-Webapp-CodeDeploy-Application`
        - Deployment group: `Java-Webapp-CodeDeploy-DG`
        - Click `Next`
    
    - Click `CREATE PIPELINE`
    - NOTE: Once you create the pipeline, it'll start Running Immediate. Just wait for all the various stages to complete

## 10) REVIEW ALL JOBS 
- Go through the `CodeBuild JOB Output`
- Go through the `CodeDeploy JOB Output`

## 11) TEST APPLICATION
- Navigate to `CodeBuild`
    - Click on the Project 
    - Click on Build Phases and Confirm the Validate Script/Phase Was Successful

- Navigate to EC2 
    - Copy the Public IP Addresses of the Instances and Try Accessing the Application
    - URL: INSTANCE_PUBLIC_IP:8080/webapp

#### CONGRATULATIONS!! CONGRATULATIONS!! CONGRATULATIONS!!



