# End-to-End Jenkins CI/CD Pipeline Project Architecture (Java Web Application)
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

# Jenkins Complete CI/CD Pipeline Environment Setup Runbook
1) Create a GitHub Repository with the name `Jenkins-CICD-Project` and push the code in this branch(main) to 
    your remote repository (your newly created repository). 
    - Go to GitHub (github.com)
    - Login to your GitHub Account
    - Create a Repository called "Jenkins-CICD-Project"
    - Clone the Repository in the "Repository" directory/folder in your local
    - Download the code in in this repository "Main branch": https://github.com/awanmbandi/realworld-cicd-pipeline-project.git
    - Unzip the code/zipped file
    - Copy and Paste everything from the zipped file into the repository you cloned in your local
    - Add the code to git, commit and push it to your upstream branch "main or master"
    - Confirm that the code exist on GitHub

2) Jenkins/Maven/Ansible
    - Create an Amazon Linux 2 VM instance 
    - Name: Jenkins/Maven/Ansible
    - Instance type: t2.medium
    - Security Group (Edit/Open): 8080, 9100 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-nexus-sonarqube-jenkins-install/jenkins-install.sh
    - Launch Instance

3) SonarQube
    - Create an Create an Ubuntu 20.04 VM instance 
    - Name: SonarQube
    - Instance type: t2.medium
    - Security Group (Eit/Open): 9000, 9100 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-nexus-sonarqube-jenkins-install/sonarqube-install.sh
    - Launch Instance

4) Nexus
    - Create an Amazon Linux 2 VM instance 
    - Name: Nexus
    - Instance type: t2.medium
    - Security Group (Eit/Open): 8081, 9100 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-nexus-sonarqube-jenkins-install/nexus-install.sh
    - Launch Instance

5) EC2 (Dev/Stage/Prod)
    - Create 3 Amazon Linux 2 VM instance
    - Names: Dev-Env, Stage-Env and Prod-Env
    - Number: `3`
    - Instance type: t2.micro
    - Security Group (Eit/Open): 8080, 9100, 9997 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/tomcat-splunk-installation/tomcat-ssh-configure.sh
    - Launch Instance

6) Prometheus
    - Create an Ubuntu 20.04 VM instance 
    - Name: Prometheus
    - Instance type: t2.micro
    - Security Group (Eit/Open): 9090 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - Launch Instance

7) Grafana
    - Create an Ubuntu 20.04 VM instance
    - Name: Grafana
    - Instance type: t2.micro
    - Security Group (Eit/Open): 3000 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - Launch Instance

8) EC2 (Splunk)
    - Create an Amazon Linux 2 VM instance
    - Name: Splunk-Indexer
    - Instance type: t2.large
    - Security Group (Eit/Open): 22, 8000, 9997, 9100 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - Launch Instance

#### NOTE: Confirm and make sure you have a total of 8 VM instances
![PipelineEnvSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-26%20at%202.51.21%20PM.png)

9) Slack 
    - Go to the bellow Workspace and create a Private Slack Channel and name it "yourfirstname-jenkins-cicd-pipeline-alerts"
    - Link: https://join.slack.com/t/realworldcicdproject/shared_invite/zt-1tryd7x1v-g8a~zEJBKKchVvvK87jkeQ  
      - You can either join through the browser or your local Slack App
      - Create a `Private Channel` using the naming convention `cicd-pipeline-project-alerts`
      - Click on the Drop down on the Channel and select Integrations and take `Add an App`
      - Search for `Jenkins` and click on `View` -->> `Configuration/Install` -->> `Add to Slack` 
      - On Post to Channel: Click the Drop Down and select your channel above `cicd-pipeline-project-alerts`
      - Click `Add Jenkins CI Integration`
      - SAVE SETTINGS/CONFIGURATIONS
      - Leave this page open
      ![SlackConfig!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-26%20at%202.08.55%20PM.png)
    
    #### NOTE: Update Your Jenkins file with your Slack Channel Name
    - Go back to your local, open your "Jenkins-CICD-Project" repo/folder/directory on VSCODE
    - Open your "Jenkinsfile"
    - Update the slack channel name on line "97" (there about)
    - Change name from "cicd-project-alerts" (or whatever name thst's there) to yours
    - Add the changes to git, commit and push to GitHub
    - Confirm the changes are available on GitHub
		- Save and Push to GitHub

## Configure All Systems
### Configure Promitheus
  - Login/SSH to your Prometheus Server
  - Clone the following repository: https://github.com/awanmbandi/realworld-cicd-pipeline-project.git
  - Change directory to "realworld-cicd-pipeline-project"
  - Swtitch to the "prometheus-and-grafana" git branch  
  - Run: ./install-prometheus.sh
  - Confirm the status shows "Active (running)"
  - Exit

### Configure Grafana
  - Login/SSH to your Grafana Server
  - Clone the following repository: https://github.com/awanmbandi/realworld-cicd-pipeline-project.git
  - Change directory to "realworld-cicd-pipeline-project"
  - Swtitch to the "prometheus-and-grafana" git branch 
  - Run: ls or ll  (to confirm you have the branch files)
  - Run: ./install-grafana.sh
  - Confirm the status shows "Active (running)"
  - Exit

### Configure The "Node Exporter" accross the "Dev", "Stage" and "Prod" instances including your "Pipeline Infra"
  - Login/SSH into the "Dev-Env", "Stage-Env" and "Prod-Env" VM instance
  - Perform the following operations on all of them
  - Install git by running: sudo yum install git -y 
  - Clone the following repository: https://github.com/awanmbandi/realworld-cicd-pipeline-project.git
  - Change directory to "realworld-cicd-pipeline-project"
  - Swtitch to the "prometheus-and-grafana" git branch 
  - Run: ls or ll  (to confirm you have the branch files)
  - Run: ./install-node-exporter.sh
  - Confirm the status shows "Active (running)"
  - Access the Node Exporters running on port "9100", open your browser and run the below
      - Dev-EnvPublicIPaddress:9100   (Confirm this page is accessible)
      - Stage-EnvPublicIPaddress:9100   (Confirm this page is accessible)
      - Prod-EnvPublicIPaddress:9100   (Confirm this page is accessible)
  - Exit

### Configure The "Node Exporter" on the "Jenkins-Maven-Ansible", "Nexus" and "SonarQube" instances 
  - Login/SSH into the "Jenkins-Maven-Ansible", "Nexus" and "SonarQube" VM instance
  - Perform the following operations on all of them
  - Install git by running: sudo yum install git -y    (The SonarQube server already has git)
  - Clone the following repository: https://github.com/awanmbandi/realworld-cicd-pipeline-project.git
  - Change directory to "realworld-cicd-pipeline-project"
  - Swtitch to the "prometheus-and-grafana" git branch 
  - Run: ls or ll  (to confirm you have the branch files including "install-node-exporter.sh")
  - Run: ./install-node-exporter.sh
  - Make sure the status shows "Active (running)"
  - Access the Node Exporters running on port "9100", open your browser and run the below
      - Jenkins-Maven-AnsiblePublicIPaddress:9100   (Confirm the pages are accessible)
      - NexusPublicIPaddress:9100   
      - SonarQubePublicIPaddress:9100   
  - Exit
  ![NodeExporter!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-26%20at%202.00.23%20PM.png)

### Update the Prometheus config file and include all the IP Addresses of the Pipeline Instances that are 
  running the Node Exporter API. That'll include ("Dev", "Stage", "Prod", "Jenkins-Maven-Ansible", "Nexus" and "SonarQube")
  - SSH into the Prometheus instance either using your GitBash (Windows) or Terminal (macOS) or browser
  - Run the command: sudo vi /etc/prometheus/prometheus.yml
      - Navigate to "- targets: ['localhost:9090']" and add the "IPAddress:9100" for all the above Pipeline instances. Ecample "- targets: ['localhost:9090', 'DevIPAddress:9100', 'StageIPAddress:9100', 'ProdIPAddress:9100', 'Jenkins-Maven-AnsibleIPAddress:9100'] ETC..."
      - Save the Config File and Quit
  - Open a TAB on your choice browser
  - Copy the Prometheus PublicIP Addres and paste on the browser/tab with port 9100 e.g "PrometheusPublicIPAddres:9100"
      - Once you get to the Prometheus Dashboard Click on "Status" and Click on "Targets"
  - Confirm that Prometheus is able to reach everyone of your Nodes, do this by confirming the Status "UP" (green)
  - Done
  ![ConfigurePrometheus!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/prometheus-targets.png)

### Open a New Tab on your browser for Grafana also if you've not done so already. 
  - Copy your Grafana Instance Public IP and put on the browser with port 3000 e.g "GrafanaPublic:3000"
  - Once the UI Opens pass the following username and password
      - Username: admin
      - Password: admin
      - New Username: admin
      - New Password: admin
      - Save and Continue
  ![ConfigureGrafana!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/raspberry-grafana-login-window-e1560717895280.png)
  - Once you get into Grafana, follow the below steps to Import a Dashboard into Grafana to visualize your Infrastructure/App Metrics
      - Click on "Configuration/Settings" on your left
      - Click on "Data Sources"
      - Click on "Add Data Source"
      - Select Prometheus
      - Underneath HTTP URL: http://PrometheusPublicOrPrivateIPaddress:9090
      - Click on "SAVE and TEST"
  - Navigate to "Create" on your left (the `+` sign)
      - Click on "Import"
      - Copy the following link: https://grafana.com/grafana/dashboards/1860
      - Paste the above link where you have "Import Via Grafana.com"
      - Click on Load (The one right beside the link you just pasted)
      - Scrol down to "Prometheus" and select the "Data Source" you defined ealier which is "Prometheus"
      - CLICK on "Import"
  - Refresh your Grafana Dashbaord 
      - Click on the "Drop Down" for "Host" and select any of the "Instances(IP)"
  ![GrafanaMetrics!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/1_KimwgjULRZzONpjGFH1sTA%20(1).png)

### Setup Splunk Server and Configure Forwarders
#### A) SSH into your `Splunk Server` including `Dev`, `Stage` and `Prod` Instances to Configure Splunk
- **NOTE:** Execute and Perform all operations across all your `Dev, Stage and Prod` Environments
- **NOTE:** Run all commands and queries across all your VMs (Dev, Stage and Prod)
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
- Enter administrator ``username`` and ``password``, remember this because you will need this to log into the application
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
        - **Restart Splunk** (For those changes to be captured):  `./splunk restart`
        ![SplunkSetup4!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-07-02%20at%209.50.16%20PM.png)
    - Refresh The Splunk Tab at http://Splunk-Server-IP:8000 and log back into splunk

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

- Change to the splunkforwarder bin directory and start the forwarder
- NOTE: The Password must be at least `8` characters long.
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

2. Navigate Back to Your `Splunk Indexer/Server` 
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
    - Plugins: Choose Install Suggested Plugings 
    - Provide 
        - Username: **admin**
        - Password: **admin**
        - Name and Email can also be admin. You can use `admin` all, as its a poc.
    - Continue and Start using Jenkins
    ![JenkinsSetup2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%208.49.43%20AM.png) 

2)  #### Plugin installations:
    - Click on "Manage Jenkins"
    - Click on "Plugin Manager"
    - Click "Available"
    - Search and Install the following Plugings "Install Without Restart"
        - **SonarQube Scanner**
        - **Maven Integration**
        - **Pipeline Maven Integration**
        - **Maven Release Plug-In**
        - **Slack Notification**
        - **Nexus Artifact Uploader**
        - **Build Timestamp (Needed for Artifact versioning)**
    - Once all plugins are installed, select **Restart Jenkins when installation is complete and no jobs are running**
    ![PluginInstallation!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%2010.07.32%20PM.png)

3)  #### Global tools configuration:
    - Click on Manage Jenkins -->> Global Tool Configuration
    ![JDKSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%208.59.50%20AM.png)

        **JDK** -->> Add JDK -->> Make sure **Install automatically** is enabled -->> 
        
        **Note:** By default the **Install Oracle Java SE Development Kit from the website** make sure to close that option by clicking on the image as shown below.

        ![JDKSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%208.59.50%20AM.png)

        * Click on Add installer
        * Select Extract *.zip/*.tar.gz -->> Fill the below values
        * Name: **localJdk**
        * Download URL for binary archive: **https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz**
        * Subdirectory of extracted archive: **jdk-11.0.1**
    - **Git** -->> Add Git -->> Install automatically(Optional)
      ![GitSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%209.36.23%20AM.png)
    
    - **SonarQube Scanner** -->> Add SonarQube Scanner -->> Install automatically(Optional)
      ![SonarQubeScanner!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%209.35.20%20AM.png)

    - **Maven** -->> Add Maven -->> Make sure **Install automatically** is enabled -->> Install from Apache -->> Fill the below values
      * Name: **localMaven**
      * Version: Keep the default version as it is 
    - Click on SAVE
    ![MavenSetup!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-24%20at%209.44.14%20AM.png)
    




