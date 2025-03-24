## Prerequisites
* Confirm that you have an active `AWS account`.
* Use a `Region` that offers the `CodeArtifact` service.
* Confirm you have `Git` configured on your local system.
* Confirm that you have a `GitHub` account.
* Confirm that you have at least one `IDE` software installed locally.

**NOTE:** 
* Navigate to a Region on AWS that has all the AWS Code services (CodeCommit, CodeBuild, CodeArtifact, CodeDeploy and CodePipeline)
* You must `Login` as an `IAM User` before you can complete the below steps successfully (Login with a user that has Administrator Privileges)

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

## 4) Create An S3 Bucket Where The Build Artifact Will Be Stored
- Navigate to Amazon S3
![S3!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.15.44%20PM.png)
- Click `Create Bucket` 
    - Name: `java-webapp-project-artifact-YOUR_ACCOUNT_ID`
    - Region: `Select Your working Region`
        - **NOTE:** Confirm the Region selected is your working Region
    - Click: `CREATE Bucket`

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

## 13) Create CodeDeploy Application
- Navigate to CodeDeploy
![CDApp!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%205.11.57%20PM.png)
- Click on `Applications`
    - Click `Create Application`
        - Name: `Java-Webapp-CodeDeploy-Application`
        - Compute Platform: `EC2/On-premises`
        - Click `Create Application`

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
