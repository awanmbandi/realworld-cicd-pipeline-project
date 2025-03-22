# End-to-End Jenkins CI/CD Pipeline Project (Arch)
![CompleteCICDProject!](https://lucid.app/publicSegments/view/0c183bd6-73f4-4547-93e1-5246db5e863c/image.png) 

###### Project ToolBox 🧰
- [Git](https://git-scm.com/) Git will be used to manage our application source code.
- [Github](https://github.com/) Github is a free and open source distributed VCS designed to handle everything from small to very large projects with speed and efficiency
- [Jenkins](https://www.jenkins.io/) Jenkins is an open source automation CI tool which enables developers around the world to reliably build, test, and deploy their software
- [Maven](https://maven.apache.org/) Maven will be used for the application packaging and building including running unit test cases
- [Checkstyle](https://checkstyle.sourceforge.io/) Checkstyle is a static code analysis tool used in software development for checking if Java source code is compliant with specified coding rules and practices.
- [SonarQube](https://docs.sonarqube.org/) SonarQube Catches bugs and vulnerabilities in your app, with thousands of automated Static Code Analysis rules.
- [Nexus](https://www.sonatype.com/) Nexus Manage Binaries and build artifacts across your software supply chain
- [Ansible](https://docs.ansible.com/) Ansible will be used for the application deployment to both lower environments and production
- [EC2](https://aws.amazon.com/ec2/) EC2 allows users to rent virtual computers (EC2) to run their own workloads and applications.
- [Slack](https://slack.com/) Slack is a communication platform designed for collaboration which can be leveraged to build and develop a very robust DevOps culture. Will be used for Continuous feedback loop.
- [Prometheus](https://prometheus.io/) Prometheus is a free software application used for event/metric monitoring and alerting for both application and infrastructure.
- [Grafana](https://grafana.com/) Grafana is a multi-platform open source analytics and interactive visualization web application. It provides charts, graphs, and alerts for the web when connected to supported data sources.
- [Splunk](https://www.splunk.com/) Splunk is an innovative technology which searches and indexes application/system log files and helps organizations derive insights from the data.

# Jenkins Complete CI/CD Pipeline Project Runbook
1) Create a GitHub Repository with the name `Jenkins-Realworld-CICD-Project` and push the code in this branch(main) to 
    your remote repository (your newly created repository). 
    - Go to GitHub: https://github.com
    - Login to `Your GitHub Account`
    - Create a Repository called `Jenkins-Realworld-CICD-Project`
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
    ![ProjectRepositoryCode!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/project-repository-code2.png)

2) Create An IAM Profile/Role For The Ansible Automation Engine (Dynamic Inventory)
- Create an EC2 Service Role in IAM with AmazonEC2FullAccess Privilege 
- Navigate to IAM
![IAM!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-10-03%20at%206.20.44%20PM.png)
    - Click on `Roles`
    - Click on `Create Role`
    - Select `Service Role`
    - Use Case: Select `EC2`
    - Click on `Next` 
    - Attach Policy: `AmazonEC2FullAccess`
    - Click `Next` 
    - Role Name: `AWS-EC2FullAccess-Role`
    - Click `Create`

3) Jenkins/Maven/Ansible
    - Create a Jenkins VM instance 
    - Name: `Jenkins/Maven/Ansible`
    - AMI: `Amazon Linux 2`
    - Instance type: `t2.medium`
    - Key pair: `Select` or `create a new keypair`
    - Security Group (Edit/Open): `8080, 9100` and `22 to 0.0.0.0/0`
    - IAM instance profile: Select the `AWS-EC2FullAccess-Role`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-nexus-sonarqube-jenkins-install/jenkins-install.sh
    - Launch Instance

4) SonarQube
    - Create a SonarQube VM instance 
    - Name: `SonarQube`
    - AMI: `Ubuntu 24.04`
    - Instance type: `t2.medium`
    - Key pair: `Select a keypair`
    - Security Group (Eit/Open): `9000, 9100` and `22 to 0.0.0.0/0`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-nexus-sonarqube-jenkins-install/sonarqube-install.sh
    - Launch Instance

5) Nexus
    - Create a Nexus VM instance 
    - Name: `Nexus`
    - AMI: `Ubuntu 24.04`
    - Instance type: `t2.large`
    - Key pair: `Select a keypair`
    - Security Group (Eit/Open): `8081, 9100` and `22 to 0.0.0.0/0`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-sonarqube-nexus-jenkins-install/nexus-install-t2large.sh
    - Launch Instance

6) EC2 (Dev Environment)
    - Create a Development VM instance
    - Click `Add additional tags`
      - Tag 1: Name: `Name`, Value: `Dev-Env`
      - Tag 2: Name: `Environment`, Value: `dev`
    - AMI: `Amazon Linux 2`
    - Number: `1`
    - Instance type: `t2.micro`
    - Key pair: `Select a keypair`
    - Security Group (Eit/Open): `8080, 9100, 9997` and `22 to 0.0.0.0/0`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/tomcat-splunk-installation/tomcat-ssh-configure.sh
    - Launch Instance

7) EC2 (Stage Environment)
    - Create a Staging VM instance
    - Click `Add additional tags`
      - Tag 1: Name: `Name`, Value: `Stage-Env`
      - Tag 2: Name: `Environment`, Value: `stage`
    - AMI: `Amazon Linux 2`
    - Number: `1`
    - Instance type: `t2.micro`
    - Key pair: `Select a keypair`
    - Security Group (Eit/Open): `8080, 9100, 9997` and `22 to 0.0.0.0/0`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/tomcat-splunk-installation/tomcat-ssh-configure.sh
    - Launch Instance

8) EC2 (Prod Environment)
    - Create a Production VM instance
    - Click `Add additional tags`
      - Tag 1: Name: `Name`, Value: `Prod-Env`
      - Tag 2: Name: `Environment`, Value: `prod`
    - AMI: `Amazon Linux 2`
    - Number: `1`
    - Instance type: `t2.micro`
    - Key pair: `Select a keypair`
    - Security Group (Eit/Open): `8080, 9100, 9997` and `22 to 0.0.0.0/0`
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/tomcat-splunk-installation/tomcat-ssh-configure.sh
    - Launch Instance

9) Prometheus
    - Create a Prometheus VM instance 
    - Name: `Prometheus`
    - AMI: `Ubuntu 24.04`
    - Instance type: `t2.micro`
    - Key pair: `Select a keypair`
    - Security Group (Eit/Open): `9090` and `22 to 0.0.0.0/0`
    - IAM instance profile: Select the `AWS-EC2FullAccess-Role`
    - Launch Instance

10) Grafana
    - Create a Grafana VM instance
    - Name: `Grafana`
    - AMI: `Ubuntu 24.04`
    - Instance type: `t2.micro`
    - Key pair: `Select a keypair`
    - Security Group (Eit/Open): `3000` and `22 to 0.0.0.0/0`
    - Launch Instance

11) EC2 (Splunk)
    - Create a Splunk/Indexer VM instance
    - Name: `Splunk-Indexer`
    - AMI: `Amazon Linux 2`
    - Instance type: `t2.large`
    - Key pair: `Select a keypair`
    - Security Group (Eit/Open): `22, 8000, 9997, 9100` to `0.0.0.0/0`
    - Launch Instance

#### NOTE: Confirm and make sure you have a total of 9 VM instances
![PipelineEnvSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screenshot%202024-02-10%20at%202.17.03%E2%80%AFPM.png)

12) Slack 
    - Go to the bellow Workspace and create a Private Slack Channel and name it "yourfirstname-jenkins-cicd-pipeline-alerts"
    - Link: https://join.slack.com/t/jjtechtowerba-zuj7343/shared_invite/zt-24mgawshy-EhixQsRyVuCo8UD~AbhQYQ  
      - You can either join through the browser or your local Slack App
      - Create a `Private Channel` using the naming convention `YOUR_INITIAL-cicd-pipeline-alerts`
        - **NOTE:** *`(The Channel Name Must Be Unique, meaning it must be available for use)`*
      - Visibility: Select `Private`
      - Click on the `Channel Drop Down` and select `Integrations` and Click on `Add an App`
      - Search for `Jenkins` and Click on `View`
      - Click on `Configuration/Install` and Click `Add to Slack` 
      - On Post to Channel: Click the Drop Down and select your channel above `YOUR_INITIAL-cicd-pipeline-alerts`
      - Click `Add Jenkins CI Integration`
      - Scrol Down and Click `SAVE SETTINGS/CONFIGURATIONS`
      - Leave this page open
      ![SlackConfig!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-26%20at%202.08.55%20PM.png)
    
    #### NOTE: Update Your Jenkins file with your Slack Channel Name
    - Go back to your local, open your `Jenkins-Realworld-CICD-Project` repo/folder/directory on VSCODE
    - Open your `Jenkinsfile`
    - Update the slack channel name on line `"133"` (there about)
    - Change the name from whatever that is there to your Slack Channel Name `YOUR_INITIAL-cicd-pipeline-alerts`
        - Bring up your `Terminal` (Depending on your machine type) and run the following commands
        - Add the changes to git: `git add -A`
        - Commit the changes: `git commit -m "updated Jenkinsfile with slack channel name"`
        - Push the changes to GitHub: `git push` 
    - Confirm that the changes are available on GitHub

## Configure All Systems
### Configure Promitheus With (Service Discovery)
  - Login/SSH to your Prometheus Server
  - Clone repository: `git clone https://github.com/awanmbandi/realworld-cicd-pipeline-project.git`
  - Change directory: `cd realworld-cicd-pipeline-project`
  - Swtitch branch: `git switch prometheus-and-grafana-install`
  - Confirm Branch Switch: `git branch` and `ls -al`
  - Change directory to Service Discovery: `cd service-discovery`
  - Install Prometheus: `bash install-prometheus.sh`
  - Confirm the status shows *"Active (running)"*
  - Exit

### Configure Grafana
  - Login/SSH to your Grafana Server
  - Clone repository: `git clone https://github.com/awanmbandi/realworld-cicd-pipeline-project.git`
  - Change directory: `cd realworld-cicd-pipeline-project`
  - Swtitch branch: `git switch prometheus-and-grafana-install`
  - Confirm Branch Switch: `git branch` and `ls -al`
  - Install Prometheus: `bash install-grafana.sh`
  - Confirm the status shows *"Active (running)"*
  - Exit

### Configure The "Node Exporter" on the "Dev", "Stage" and "Prod" instances including your "Pipeline Infra"
  - Login/SSH into the "Dev-Env", "Stage-Env" and "Prod-Env" VM instance
  - Perform the following operations on all of them
  - Install git by running: `sudo yum install git -y `
  - Clone repository: `git clone https://github.com/awanmbandi/realworld-cicd-pipeline-project.git`
  - Change directory: `cd realworld-cicd-pipeline-project`
  - Swtitch branch: `git switch prometheus-and-grafana-install`
  - Confirm Branch Switch: `git branch` and `ls -al` *(to confirm you have the branch files)*
  - Install The Node Exporter: `bash install-node-exporter.sh`
  - Confirm the status shows *"Active (running)"*
  - Access the Node Exporters running on port "9100", open your browser and run the below
      - Dev-EnvPublicIPaddress:9100   (Confirm this page is accessible)
      - Stage-EnvPublicIPaddress:9100   (Confirm this page is accessible)
      - Prod-EnvPublicIPaddress:9100   (Confirm this page is accessible)
  - Exit

### Configure The "Node Exporter" on the "Jenkins-Maven-Ansible", "Nexus" and "SonarQube" instances 
  - Login/SSH into the `"Jenkins-Maven-Ansible"`, `"Nexus"` and `"SonarQube"` VM instance
  - Perform the following operations on all of them
  - Install git: 
    - Jenkins/Maven/Ansible and Nexus VMs: `sudo yum install git -y`   
    - SonarQube VM: `sudo apt install git -y`
  - Clone repository: `git clone https://github.com/awanmbandi/realworld-cicd-pipeline-project.git`
  - Change directory: `cd realworld-cicd-pipeline-project`
  - Swtitch branch: `git switch prometheus-and-grafana-install`
  - Confirm Branch Switch: `git branch` and `ls -al` *(to confirm you have the branch files)*
  - Install The Node Exporter: `bash install-node-exporter.sh`
  - Confirm the status shows *"Active (running)"*
  - Access the Node Exporters running on port `"9100"`, open your browser and run the below
      - Jenkins-Maven-AnsiblePublicIPaddress:9100   (Confirm the pages are accessible)
      - NexusPublicIPaddress:9100   
      - SonarQubePublicIPaddress:9100   
  - Exit
  ![NodeExporter!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-26%20at%202.00.23%20PM.png)

### Confirm That The Prometheus Service Disconvery Config Works As Expected
  - Open a TAB on your choice `Browser`
  - Copy the Prometheus `PublicIP Address` and paste on the `browser/tab` with port `9090` e.g `"PrometheusPublicIPAddres:9090"`
      - Once you get to the Prometheus Dashboard Click on `"Status"` and Click on `"Targets"`
  - Confirm that Prometheus is able to reach everyone of your `Nodes`, do this by confirming the Status `"UP" (green)`
  ![ConfigurePrometheus!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screenshot%202024-02-10%20at%204.44.02%E2%80%AFPM.png)

### Open a New Tab on your browser for Grafana also if you've not done so already. 
  - Copy your `Grafana Instance Public IP` and put on the browser with port `3000` e.g `"GrafanaInstancePublic:3000"`
  - Once the UI Opens pass the following username and password
      - Username: `admin`
      - Password: `admin`
      - Click on `Log In`
      - New Username: `admin`
      - New Password: `admin`
      - Click on `Submit`
  ![ConfigureGrafana!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/sagdsgfsa.png)
  - Once you get into Grafana, follow the below steps to Import a Dashboard into Grafana to visualize your Infrastructure/App Metrics
      - Click on `Configuration/Settings` on your left
      - Click on `Data Sources`
      - Click on `Add Data Source`
      - Select `Prometheus`
      - Underneath `HTTP URL`: `http://PrometheusPublicOrPrivateIPaddress:9090`
      - Click on `SAVE and TEST`
  - Download the Prometheus `Node Exporter Full` Grafana Dashboard JSON
    - Click on this link to Download the JSON: https://grafana.com/api/dashboards/1860/revisions/25/download
    - **NOTE:** *(Confirm that the Dashboard JSON was downloaded successfully)*

  - Navigate to `"Create"` on your left (the `+` sign) on Grafana
      - Click on `Import`
      - Click on `Upload JSON file` and Select the `Dashboard JASON` file you just downloaded
  ![GrafanaMetrics!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/fwefwrfwrsgvsd.png)
      - Scrol down to `"Prometheus"` and select the `"Prometheus Data Source"` you defined ealier which is `Prometheus`
      - CLICK on `"Import"`
  - Refresh your Grafana Dashbaord 
      - Click on the `"Drop Down"` for `"Host"` and select any of the `"Instances(IP)"`
  ![GrafanaMetrics!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/1_KimwgjULRZzONpjGFH1sTA%20(1).png)

### Setup Splunk Server/Indexer and Configure Forwarders
#### A) SSH into your `Splunk Server` including `Dev`, `Stage` and `Prod` Instances
- **NOTE:** Run The Following Commands On The `Splunk Server/Indexer Only`
    - Download the Splunk RPM installer package for Linux
    - Link: 
    ```bash
    wget -O splunk-9.1.1-64e843ea36b1.x86_64.rpm "https://download.splunk.com/products/splunk/releases/9.1.1/linux/splunk-9.1.1-64e843ea36b1.x86_64.rpm"
    ```
    - Install Splunk
    ```
    sudo yum install ./splunk-9.1.1-64e843ea36b1.x86_64.rpm -y
    ```
    - Start the splunk server 
    ```bash
    sudo bash
    cd /opt/splunk/bin
    ./splunk start --accept-license --answer-yes
    ```
- Enter `adminadmin` as the ``username`` and as the ``password``, remember this because you will need this to log into Splunk on the Browser
- NOTE: The Password must be up to `8` characters. You can assign `adminadmin`
    ![SplunkSetup1!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-28%20at%2010.48.24%20AM%20copy.png)

- Access your Splunk Installation at http://Splunk-Server-IP:8000 and log into splunk
    - Username: `admin`, Password: `Same Password You Just Configured Above`
    ![SplunkSetup2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/splunk-login-page.png)

- **NOTE(MANDATORY):** Once you login to the splunk Indexer
    - Click on `Settings` 
        - Click `Server Settings` 
        - Click `General Settings`
        - Go ahead and Change the `Pause indexing if free disk space` from `5000 to 50`
    - Click on `Save`

    - Confirm that 
    ![SplunkSetup3!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-29%20at%2010.34.45%20PM.png)

    - **NOTE:** If You Do Not Complete This Part Your Splunk Configuration Won't Work
- **IMPORTANT:** Navigate Back to your `Terminal` where you're `Configuring the Indexer`
- **Restart Splunk** (For those changes to be captured): RUN the command `./splunk restart`
![SplunkSetup4!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-07-02%20at%209.50.16%20PM.png)
- Refresh The Splunk Tab at http://Splunk-Server-IP:8000 and *`log back into splunk`*
- After `Logging In Back` into Splunk, Confirm that your Stat's Showing Green as shown in the screenshot below
![SplunkSetup4!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/fwefwrfwrsgvsdsd.png) 

#### Step 2: Install The Splunk Forwarder only on the `Dev, Stage and Prod` Servers
- **NOTE:** Execute every command mentioned bellow across all application servers in all the enviroments
- **NOTE:** Do Not install the Splunk Server in these resources/environments
- **SSH** Into your instances, as normal user `ec2-user` or ubuntu or centos etc

- Download the Splunk forwarder RPM installer package 
```bash
wget -O splunkforwarder-9.1.1-64e843ea36b1.x86_64.rpm "https://download.splunk.com/products/universalforwarder/releases/9.1.1/linux/splunkforwarder-9.1.1-64e843ea36b1.x86_64.rpm"
```
- Install the Forwarder
```bash
ls -al
sudo yum install ./splunkforwarder-9.1.1-64e843ea36b1.x86_64.rpm -y
```

- Change to the `splunkforwarder bin` directory and start the forwarder
- NOTE: `The Password` must be at least `8` characters long.
- Set the port for the forwarder to ``9997``, this is to keep splunk server from conflicting with the splunk forwarder
```bash
sudo bash
cd /opt/splunkforwarder/bin
./splunk start --accept-license --answer-yes
```

- Set the forwarder to forward to the splunk server on port ``9997``, and will need to enter username and password (change IP address with your own server IP address). When prompted for username and password, enter what you set above for username and password.
```
./splunk add forward-server SPLUNK-SERVER-Public-IP-Address:9997
```

- Restart Splunk on the VM you are configuring the Forwarder
```
./splunk restart
```

- Set the forwarder to monitor the ``/var/log/tomcat/`` directory and restart
```
./splunk add monitor /var/log/tomcat/
```

### 2. Navigate Back to Your `Splunk Indexer/Server` 
- Set the port for the Splunk Indexer or Server to listen on 9997 and restart
```bash
cd /opt/splunk/bin
./splunk enable listen 9997
```
- Restart Splunk on the VM you are configuring the Forwarder
```
./splunk restart
```

#### Step 3: View Application Logs in Splunk
- Login to your `Splunk Server` at http://Splunk-Server-IP:8000
- Click on `Search and Reporting` -->> `Data Summary` -->> Select any of the displayed `Environments Host` to visualize `App Logs`
![SplunkSetup4!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-29%20at%2011.39.03%20PM.png)

- Application Log Indexed
![SplunkSetup3!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-29%20at%2010.55.36%20PM.png)

### Jenkins setup
1) #### Access Jenkins
    Copy your Jenkins Public IP Address and paste on the browser = ExternalIP:8080
    - Login to your Jenkins instance using your Shell (GitBash or your Mac Terminal)
    - Copy the Path from the Jenkins UI to get the Administrator Password
        - Run: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
        - Copy the password and login to Jenkins
    ![JenkinsSetup1!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/jenkins-signup.png) 
    - Plugins: Choose `Install Suggested Plugings` 
    - Provide 
        - Username: **`admin`**
        - Password: **`admin`**
        - `Name` and `Email` can also be admin. You can use `admin` all, as its a poc.
    - Click `Continue`
    - Click on `Start using Jenkins`
    ![JenkinsSetup2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%208.49.43%20AM.png) 

2)  #### Plugin installations:
    - Click on `Manage Jenkins`
    - Click on `Plugins`
    - Click `Available`
    - Search and Install the following Plugings and `"Install"`
        - **SonarQube Scanner**
        - **Maven Integration**
        - **Pipeline Maven Integration**
        - **Maven Release Plug-In**
        - **Slack Notification**
        - **Nexus Artifact Uploader**
        - **Pipeline: Stage View**
        - **Blue Ocean**
        - **Build Timestamp (Needed for Artifact versioning)**
    - Click on `Install`
    - Once all plugins are installed
    - Select/Check the Box **Restart Jenkins when installation is complete and no jobs are running**
    ![PluginInstallation!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2010.07.32%20PM.png)
    - Refresh your Browser and Log back into Jenkins
    - Once you log back into Jenkins

3)  #### Global tools configuration:
    - Click on Manage Jenkins -->> Global Tool Configuration
    ![JDKSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/sdsdsdsdsd.png)

    - **JDK** 
        - Click on `Add JDK` -->> Make sure **Install automatically** is enabled 
        
        **Note:** By default the **Install Oracle Java SE Development Kit from the website** make sure to close that option by clicking on the image as shown below.

        ![JDKSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/dsdsdsdsdsd.png)

        * Click on `Add installer`
        * Select `Extract *.zip/*.tar.gz` 
        * Name: **`localJdk`**
        * Download URL for binary archive: **https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz**
        * Subdirectory of extracted archive: **`jdk-11.0.1`**
    - **Git** 
      - Click on `Add Git` 
      - Enable `Install automatically`(Optional)
      ![GitSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%209.36.23%20AM.png)
    
    - **SonarQube Scanner** 
      - Click on `Add SonarQube Scanner` 
      - Enable: `Install automatically` 
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%209.35.20%20AM.png)

    - **Maven** 
      - Click on `Add Maven` 
      - Enable **`Install automatically`** is enabled 
      * Name: **`localMaven`**
      * Version: Keep the default version as it is to latest
    - Click on `SAVE`
    ![MavenSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%209.44.14%20AM.png)
    
4)  #### Credentials setup(SonarQube, Nexus, Ansible and Slack):
    - Click on `Manage Jenkins` 
      - Click on `Credentials` 
      - Click on `Global` (unrestricted)
      - Click on `Add Credentials`
      1)  ##### SonarQube secret token (SonarQube-Token)
          - ###### Generating SonarQube secret token:
              - Login to your SonarQube Application (http://SonarServer-Sublic-IP:9000)
                - Default username: **`admin`** 
                - Default password: **`admin`**
              - Click on `Projects`
              - Click on `Create New Project`
                - Project key: `JavaWebApp-Project`
                - Display name: `JavaWebApp-Project`
              - Click on `Set Up`
              - Generate a Tokens: Provide Name ``JavaWebApp-SonarQube-Token``
              - Click on `Generate`
              - Click on `Continue`
              - Run analysis on your project: Select `Java`
              - Build technology: Select `Maven`
              - COPY the `TOKEN`
          - ###### Store SonarQube Secret Token in Jenkins:
              - Navigate back to Jenkins
              - Click on ``Add Credentials``
              - Kind: Secret text!! 
              - Secret: `Paste the SonarQube token` value that we have created on the SonarQube server
              - ID: ``SonarQube-Token``
              - Description: `SonarQube-Token`
              - Click on Create

      2)  ##### Slack secret token (slack-token)
          - ###### Get The Slack Token: 
              - Slack: https://join.slack.com/t/jjtechtowerba-zuj7343/shared_invite/zt-24mgawshy-EhixQsRyVuCo8UD~AbhQYQ
              - Navigate to the Slack "Channel you created": `YOUR_INITIAL-cicd-pipeline-alerts`
              - Click on your `Channel Drop Down`
              - Click on `Integrations` and Click on `Add an App`
              - Click on `Jenkins CI VIEW` and Click on `Configuration`
              - Click on `Add to Slack`, Click on the Drop Down and `Select your Channel`
              - Click on `Add Jenkins CI Integration`
              - **`NOTE:`** *The TOKEN is on Step 3*

          - ###### Create The Slack Credential For Jenkins:
              - Click on ``Add Credentials``
              - Kind: Secret text            
              - Secret: Place the Integration Token Credential ID (Note: Generate for slack setup)
              - ID: ``Slack-Token``
              - Description: `slack-token`
              - Click on `Create`  

      3)  ##### Nexus Credentials (Username and Password)
          - ###### Login to Nexus and Set Password
              - Access Nexus: http://Nexus-Pub-IP:8081/
	          - Default Username: `admin`
	          - NOTE: Login into your "Nexus" VM and "cat" the following file to get the password.
	          - Command: ``sudo cat /opt/nexus/sonatype-work/nexus3/admin.password``
	          - Password: `Fill In The Password and Click Sign In`
	          - Click `Next` 
              - Provide New Password: `admin`
	          - Configure Anonymous Access: `Disable anonymous access`
              - Click on `Finish`

          - ###### Nexus credentials (username & password)
	          - Click on ``Add Credentials``
	          - Kind: Username with password                  
	          - Username: ``admin``
	          - Enable Treat username as secret
	          - Password: ``admin``
	          - ID: ``Nexus-Credential``
	          - Description: `nexus-credential`
	          - Click on `Create`   

      4)  ##### Ansible deployment server credential (username & password)
          - Click on ``Add Credentials``
          - Kind: Username with password          
          - Username: ``ansibleadmin``
          - Enable Treat username as secret
          - Password: ``ansibleadmin``
          - ID: ``Ansible-Credential``
          - Description: `Ansible-Credential`
          - Click on `Create`   
      ![SonarQubeServerSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%202.10.40%20PM.png)

5)  #### Configure system:    
    1)  - Click on ``Manage Jenkins`` 
        - Click on ``Configure System`` and navigate to the `SonarQube Servers` section
        - Click on Add `SonarQube`
        - Server URL: http://YOUR_SONARQUBE_PRIVATE_IP:9000
        - Server authentication token: Select `SonarQube-Token`
        ![SonarQubeServerSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2010.13.39%20AM.png)

    2)  - Still on `Manage Jenkins` and `Configure System`
        - Scroll down to the `Slack` Section (at the very bottom)
        - Go to section `Slack`
            - `NOTE:` *Make sure you still have the Slack Page that has the `team subdomain` & `integration token` open*
            - Workspace: **Replace with `Team Subdomain` value** (created above)
            - Credentials: select the `Slack-Token` credentials (created above) 
            - Default channel / member id: `#PROVIDE_YOUR_CHANNEL_NAME_HERE`
            - Click on `Test Connection`
            - Click on `Save`
        ![SlackSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2010.31.12%20AM.png)

### SonarQube Configuration
2)  ### Setup SonarQube GateKeeper
    - Click on `Quality Gate` 
    - Click on `Create`
    - Name: `JavaWebApp-QualityGate`
    ![SonarQubeSetup2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/dsdsdsdsdsdsds.png)
    - Click on `Save` to Create
    ![SonarQubeSetup2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2011.00.25%20AM.png)
    - Add a Quality Gate Condition to Validate the Code Against (Code Smells or Bugs)
    ![SonarQubeSetup3!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2011.02.36%20AM.png)
    
    - Add Quality to SonarQube Project
    -  ``NOTE:`` Make sure to update the `SonarQube` stage in your `Jenkinsfile` and Test the Pipeline so your project will be visible on the SonarQube Project Dashboard.
    - Click on `Projects` 
    - Click on your project name `JavaWebApp-Project` 
      - Click on `Project Settings`
      - Click on `Quality Gate`
      - Select your QG `JavaWebApp-QualityGate`

    ![SonarQubeSetup3!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/SDFVDSFVDFV.png)

3)  ### Setup SonarQube Webhook to Integrate Jenkins (To pass the results to Jenkins)
    - Click on `Administration` and click on `Configuration` and Select `Webhook`
    - Click on `Create Webhook` 
      - Name: `jenkinswebhook`
      - URL: `http://Jenkins-Server-Private-IP:8080/sonarqube-webhook`
    ![SonarQubeSetup4!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2011.08.26%20AM.png)

    - Go ahead and Confirm in the Jenkinsfile you have the “Quality Gate Stage”. The stage code should look like the below;
    ```bash
    stage('SonarQube GateKeeper') {
        steps {
          timeout(time : 1, unit : 'HOURS'){
          waitForQualityGate abortPipeline: true
          }
       }
    }
    ```
     - Run Your Pipeline To Test Your Quality Gate (It should PASS QG)
     - **(OPTIONAL)** FAIL Your Quality Gate: Go back to SonarQube -->> Open your Project -->> Click on Quality Gates at the top -->> Select your Project Quality Gate -->> Click EDIT -->> Change the Value to “0” -->> Update Condition
     - **(OPTIONAL)** Run/Test Your Pipeline Again and This Time Your Quality Gate Should Fail 
     - **(OPTIONAL)** Go back and Update the Quality Gate value to 10. The Exercise was just to see how Quality Gate Works

### Pipeline creation
- Update The ``Jenkinsfile`` If Neccessary
- Update `SonarQube IP address` in your `Jenkinsfile` On `Line 61`
- Update the `SonarQube projectKey or name` in your `Jenkinsfile` On `Line 60`
- Update your `Slack Channel Name` in the `Jenkinsfile` on `Line 133`
- Update Your `Nexus IP` in the `Jenkinsfile` on `Line 80`
    
    - Log into Jenkins: http://Jenkins-Public-IP:8080/
    - Click on `New Item`
    - Enter an item name: `Jenkins-Complete-CICD-Pipeline` 
    - Select the category as **`Pipeline`**
    - Click `OK`
    - Select GitHub project: Project url `Provide Your Project Repo Git URL`
    - GitHub hook trigger for GITScm polling: `Check the box` 
      - NOTE: Make sure to also configure it on GitHub's side
    - Pipeline Definition: Select `Pipeline script from SCM`
      - SCM: `Git`
      - Repositories
        - Repository URL: `Provide Your Project Repo Git URL` (the one you created in the initial phase)
        - Credentials: `none` *since the repository is public*
        - Branch Specifier (blank for 'any'): ``*/main``
        - Script Path: ``Jenkinsfile``
    - Click on `SAVE`
    - NOTE: Make Sure Your Pipeline Succeeds Until ``SonarQube GateKeeper``. Upload to Artifactory would fail.
    - Click on `Build Now` to TEST Pipeline 

    ### A. Pipeline Test Results 
    - Jenkins Pipeline Job
    ![JenkinsJobResult!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/jenkins-pipeline-first-run.png)

    - SonarQube Code Inspection Result
    ![SonarQubeResult!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/sonarqube-result.png)

    - Slack Continuous Feedback Alert
    ![SlackResult!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/slack-first-notification-from-pipeline-job2.png)

    - SonarQube GateKeeper Webhook Payload
    ![SonarQubeGateKeeper!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/sonarqube-webhook-forGateKepper-Result.png)

    ### B. Troubleshooting (Possible Issues You May Encounter and Suggested Solutions)
    1) **1st ISSUE:** If you experience a long wait time at the level of `GateKeeper`, please check if your `Sonar Webhook` is associated with your `SonarQube Project` with `SonarQube Results`
    - If you check your jenkins Pipeline you'll most likely find the below message at the `SonarQube GateKeper` stage
    ```bash
    JENKINS CONSOLE OUTPUT

    Checking status of SonarQube task 'AYfEB4IQ3rP3Y6VQ_yIa' on server 'SonarQube'
    SonarQube task 'AYfEB4IQ3rP3Y6VQ_yIa' status is 'PENDING'
    ```

### Nexus Configuration
1)  ### Navigate to Accessing Nexus: 
    The nexus service on port `8081`. To access the nexus dashboard, visit http://Nexus-Pub-IP:8081. 
    - Username: ``admin``
    - Password: `admin`

    ### Go ahead and Create your Nexus Project Repositories
    - CREATE 1st REPO (Release Repo): 
        - Click on the Gear Icon 
        - Click on `Repository` 
        - Click `Create Repository` 
        - Select Recipe: `maven2(hosted)` 
        - Name: `maven-project-releases` 
        - Version Policy: Select `Release`
        - Click `Create Repository`

    - CREATE 2nd REPO (Snapshot Repo): 
        - Click on `Create Repository` 
        - Select Recipe: `maven2(hosted)` 
        - Name: `maven-project-snapshots` 
        - Version Policy: Select `Snapshot` 
        - Click `Create Repository`

    - CREATE 3rd REPO (Proxy/Remote Repo): 
        - Click on `Create Repository` 
        - Select Recipe: `maven2(proxy)` 
        - Name: `maven-project-central` 
        - Version Policy: Select `Release`
        - Remote Storage: https://repo.maven.apache.org/maven2 
        - Click `Create Repository`

    - CREATE 4th REPO (Group Repo): 
        - Click on `Create Repository` 
        - Select Recipe: `maven2(group)` 
        - Name: `maven-project-group` 
        - Version Policy: Select `Mixed` 
        - Member Repositories: Assign All The Repos You Created to The Group 
          - **MEANING:** *Move all 3 repositories to the Box on your Right*
        - Click `Create Repository`

    ![NexusSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%203.42.03%20PM.png) 

### Update Maven POM and Integrate/Configure Nexus With Jenkins
A) Update Maven `POM.xml` file
- Update the Following lines of Code ``(Line 32 and 36)`` in the maven `POM` file and save
```bash
<url>http://Nexus-Server-Private-IP:8081/repository/maven-project-snapshots/</url>

<url>http://Nexus-Server-Private-IP:8081/repository/maven-project-releases/</url>
```

-  **`NOTE:`** Confirm that you have the following Stage in your Jenkins pipeline config. Once you Confirm, Go ahead and Update the following Values (`nexusUrl`(Your Nexus IP), `repository`, `credentialsId` (Variable)). If necessary 
- **`NOTE:`** The following `environment` config represents the NEXUS CREDENTIAL stored in jenkins. we're pulling the credential with the use of the predefine ``NEXUS_CREDENTIAL_ID`` environment variable key. Which jenkins already understands. 
  ```bash
  environment {
    WORKSPACE = "${env.WORKSPACE}"
    NEXUS_CREDENTIAL_ID = 'Nexus-Credential'
  }
  ```

- Here we're using the `Nexus Artifact Uploader` stage config to publish the app artifacts to Nexus
  ```bash
  stage("Nexus Artifact Uploader"){
      steps{
          nexusArtifactUploader(
            nexusVersion: 'nexus3',
            protocol: 'http',
            nexusUrl: '172.31.82.36:8081',
            groupId: 'webapp',
            version: "${env.BUILD_ID}-${env.BUILD_TIMESTAMP}",
            repository: 'maven-project-releases',  //"${NEXUS_REPOSITORY}",
            credentialsId: "${NEXUS_CREDENTIAL_ID}",
            artifacts: [
                [artifactId: 'webapp',
                classifier: '',
                file: '/var/lib/jenkins/workspace/jenkins-complete-cicd-pipeline/webapp/target/webapp.war',
                type: 'war']
            ]
          )
      }
  }
  ```
- After confirming all changes, go ahead and save, then push to GitHub.
    - Add the changes: `git add -A`
    - Commit changes: `git commit -m "updated project POM and Jenkinsfile"`
    - Push to GitHub: `git push`

- Test your Pipeline to `Make Sure That The Artifacts Upload Stage Succeeds` including the `Deployments`.
    - Navigate to Jenkins Dashboard (Run/Test The Job) 
    - Click on `Build Now`
![PipelineStagesArtifactSuccess!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%204.44.30%20PM.png)

- Navigate to `Nexus` as well to confirm that the artifact was `Stored` in the `maven-project-releases` repository
![ArtifactStored!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%204.08.33%20PM.png)

## Confirm Ansible Deployment to `Dev`, `Stage` and `Prod` Was Successful
- ((NOTE)): That you passed the Userdata in the `Jenkins/Maven/Ansible` and `Dev,Stage` and `Prod` Instances to Configure the Environments, then you should not have issues. And if that is the case, you do not have to perform the operations that follows this step to re-configure `Anasible` and `Tomcat` again. You just Have to confirm, the Configurations where all Successful and Move to the Next step to Setup a CI Integration Between `GitHub` and `Jenkins`.
- ((NOTE)): Confim you did `Assign an IAM ROLE / PROFILE` with `EC2 Access` to your `Jenkins` instance
- ((NOTE)): Update `ALL Pipeline Deploy Stages` with your `Ansible Credentials ID` (IMPORTANT)
- ((NOTE)): Make sure the following Userdata was executed across all the Deployment Nodes/Instances
```bash
#!/bin/bash
# Tomcat Server Installation
sudo su
amazon-linux-extras install tomcat8.5 -y
systemctl enable tomcat
systemctl start tomcat

# Provisioning Ansible Deployer Access
useradd ansibleadmin
echo ansibleadmin | passwd ansibleadmin --stdin
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "ansibleadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
```

### Setup a CI Integration Between `GitHub` and `Jenkins`
1. Navigate to your GitHub project repository
    - Open the repository
    - Click on the repository `Settings`
        - Click on `Webhooks`
        - Click `Add webhook`
            - Payload URL: http://JENKINS-PUBLIC-IP-ADDRESS/github-webhook/
            - Content type: `application/json`
            - Active: Confirm it is `Enable`
            - Click on `Add Webhook`

2. Confirm that this is Enabled at the Level of the Jenkins Job as well
    - Navigate to your Jenkins Application: http://JENKINS-PUBLIC-IP-ADDRESS:8080
        - Click on the `Job Name`
        - Navigate to `Build Triggers`
            - Enable/Check the box `GitHub hook trigger for GITScm polling`
        - Click on `Apply and Save`
### TROUBLESHOOT (BUG FIX)
#### A) Ansible Automation (Deployment)
- **`NOTE:`** If you followed the steps as mentioned in this Runbook, your pipeline normally should run successfully to the end. 
- **`NOTE:`** However, you may not be able to reach the Web Application. This could be due to the fact that you're using a different `Region` as compared to what's actually stated in the `ansible-config/aws_ec2.yaml` config script.
    - To Reolve this issue, Navigate to this file 
      - Go to your `Project Code`
      - Open the `ansible-config` folder
      - You will see the `aws_ec2.yaml` config file
    - Change the `Region` to `Your Region`
    - Commit the Changes and Push to GitHub
    - Then `Re-Run The Pipeline` 
    - Finally `Try Accessing The Application` Now from a Web Browser

- Verify that the `Jenkins/Maven/Ansible` instance has an `IAM Profile with EC2 Access`
- Also Confirm that the `Dev, Stage` and `Prod` Environments have their assigned Environment tags

### TEST PIPELINE DEPLOYMENT
- Confirm/Confirm that your deployments where all successful accross all Environments
![PipelineStagesCompleted!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%204.44.30%20PM.png)

- Verify/Confirm Slack Success Feedback.
![SlackSuccessAllStages!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-27%20at%205.06.44%20PM.png)

- Confirm Access to your application: http://Dev-or-Stage-or-Prod-PubIP:8080/webapp/
![FinalProductDisplay!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/SDFVDSFVDFVsdsd.png)

### NOTE: That By completing this project, you are now considered a Professional DevOps Engineer.  
You've been able to accomplish something very unique and special which most people only dream of in their IT journey. Remmber that during an interview, you may be asked some challenging questions or be faced with a trial assignment that require you to both utilize your existing skillsets and think out of the box. During this time you must be very confident and determined in your pursuit. 

Never forget that you have what it takes to add more than enough VALUE to any organization out there in the industry and to STAND OUT in any interview setting no matter who is sitted on the interview seat.

## Congratulations Team!!!👨🏼‍💻 Congratulations!!!👨🏼‍💻





