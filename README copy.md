## CI/CD With Jenkins For CloudFormation Templates

## Create a GitHub Repository and Update your Jenkinsfile
- Create a Repo with name `CloudFormation-Jenkins-CICD`
- Clone the Repository locally
- Download the files from my GitHub Repo and add to yours
- Update the `cloud-formation-jenkins-cicd` Slack Channel Name on Linke `45` in the `Jenkinsfile` to reflect yours (please leave the `#`)
- Commit the changes locally and push to GitHub

## Instance Criteria
- Launch an Amazon Linux 2 Instance
- Instance type: t2.large
- Name: Jenkins-Cloudformation-CICD
- Keypair: Create a Keypair With Name `work-mac-os`
- IAM Role: Assign an EC2 Role with Administrator Access (This would be used to provision the environment granting Jenkins Authorization)
- Update the security group and open port `8080` to `0.0.0.0/0`

## Join the JJTech-Eagles-CI/CD DevOps Workspace Using The Following URL
- https://join.slack.com/t/newworkspace-mtx6785/shared_invite/zt-1go3k7pz7-uSy3D4ai3Pb7KJk2G1sc1g
- You can either join though the browser or your local Slack App
- Create a `Private Channel` using the naming convention `yourFirstorLastname-cloudFormation-cicd`
- Click on the Drop down on the Channel and select Integrations and take `Add an App`
- Search for `Jenkins` and click on `View` >> `Configuration` >> `Add to Slack` 
- On Post to Channel: Click the Drop Down and select your channel above `yourFirstorLastname-cloudFormation-cicd`
- Click `Add Jenkins CI Integration`
- Leave this page open

## Install the Slack Plugin in Jenkins and Configure 
- Go back to your Jenkins instance and access the Jenkins application on the browser with `InstancePubIP:8080`
#### Plugin Installation
- Install the `Slack Notification` Plugin in Jenkins (Follow the steps in the above slack runbook)
- Go to Jenkins
    - Manage Jenkins
    - Manage Plugins
    - Click Available
    - Search `Slack Notification`
    - Select and Install Without Restart

#### Configure System
- Configure `Slack Configurations` in Jenkins > Manage Jenkins > Configure System (Scroll to the buttom)
  - Workspace: Slack Chanel name (Everyone use the same name)
  - Credential: Slack channel Token (Step 3 in Setup Document)
  - Channel/Member ID: Slack channel with the `#` infront
  - Test Connection

## Create Your Jenkins Pipeline to Deploy the CloudFormation Environment
- Go back to jenkins 
- Click on New Item
- Give a name `CloudFormation-Jenkins-CICD-Pipeline`
- Setup Build Triger
- Pipeline: Select Pipeline Script From SCM >> Complete the Config and Save

