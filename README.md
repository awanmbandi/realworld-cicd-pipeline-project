## Terraform CI/CD Automation With Jenkins
###### Project ToolBox 🧰
- [Git](https://git-scm.com/) Git will be used to manage our application source code.
- [Github](https://github.com/) Github is a free and open source distributed VCS designed to handle everything from small to very large projects with speed and efficiency
- [Jenkins](https://www.jenkins.io/) Jenkins is an open source automation CI tool which enables developers around the world to reliably build, test, and deploy their software
- [Snyk](https://snyk.io/) Snyk gives you the visibility, context, and control you need to work alongside developers on reducing application risk. 
- [Checkov](https://www.checkov.io/) Checkov scans cloud infrastructure configurations to find misconfigurations before they're deployed.
- [Slack](https://slack.com/) Slack is a communication platform designed for collaboration which can be leveraged to build and develop a very robust DevOps culture. Will be used for Continuous feedback loop.

1) Create a GitHub Repository with the name `Terraform-CICD-Pipeline-Project` and push the code in this branch(main) to 
    your remote repository (your newly created repository). 
    - Go to GitHub: https://github.com
    - Login to `Your GitHub Account`
    - Create a Repository called `Terraform-CICD-Pipeline-Project`
    - Clone the Repository in the `Repository` directory/folder on your `local machine`
    - Download the code in in this repository `"Main branch"`: https://github.com/awanmbandi/realworld-cicd-pipeline-project.git
    - `Unzip` the `code/zipped file`
    - `Copy` and `Paste` everything `from the zipped file` into the `repository you cloned` in your local
    - Open your `Terminal`
        - Add the code to git, commit and push it to your upstream branch "main or master"
        - Add the changes: `git add -A`
        - Commit changes: `git commit -m "adding project source code"`
        - Push to GitHub: `git push`
    - Confirm that the code is now available on GitHub as shown below...
    ![ProjectRepositoryCode!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/dsdsdsdgdghhgjkyutyrtegdgdr.png)

2) Create An IAM Profile/Role For The Jenkins Environment
- Create an EC2 Service Role in IAM with `AdministratorAccess` Privilege 
- Navigate to IAM
![IAM!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.20.44%20PM.png)
    - Click on `Roles`
    - Click on `Create Role`
    - Select `Service Role`
    - Use Case: Select `EC2`
    - Click on `Next` 
    - Attach Policy: `AdministratorAccess`
    - Click `Next` 
    - Role Name: `AWS-AdministratorAccess-Role`
    - Click `Create`

3) Jenkins
    - Create a Jenkins VM instance 
    - Name: `Jenkins-CI`
    - AMI: `Amazon Linux 2`
    - Instance type: `t2.medium`
    - Key pair: `Select` or `create a new keypair`
    - Security Group (Edit/Open): `8080` and `22` to `0.0.0.0/0`
    - IAM instance profile: Select the `AWS-AdministratorAccess-Role`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/terraform-jenkins-cicd-pipeline-project/installations/jenkins-install.sh
    - Launch Instance

4) Slack 
    - Go to the bellow Workspace and create a Private Slack Channel and name it "yourfirstname-jenkins-cicd-pipeline-alerts"
    - Link: https://join.slack.com/t/jjtechtowerba-zuj7343/shared_invite/zt-24mgawshy-EhixQsRyVuCo8UD~AbhQYQ  
      - You can either join through the browser or your local Slack App
      - Create a `Private Channel` using the naming convention `YOUR_INITIAL-terraform-cicd-alerts`
        - **NOTE:** *`(The Channel Name Must Be Unique, meaning it must be available for use)`*
      - Visibility: Select `Private`
      - Click on the `Channel Drop Down` and select `Integrations` and Click on `Add an App`
      - Search for `Jenkins` and Click on `View`
      - Click on `Configuration/Install` and Click `Add to Slack` 
      - On Post to Channel: Click the Drop Down and select your channel above `YOUR_INITIAL-terraform-cicd-alerts`
      - Click `Add Jenkins CI Integration`
      - Scrol Down and Click `SAVE SETTINGS/CONFIGURATIONS`
      - Leave this page open
      ![SlackConfig!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-26%20at%202.08.55%20PM.png)

5) Install Plugins
- Snyk 
- Slack
- Blue Ocean
- Pipeline: Stage View

