# End-to-End Jenkins CI/CD Pipeline Project Architecture (Java Web Application)
![CompleteCICDProject!](https://lucid.app/publicSegments/view/0c183bd6-73f4-4547-93e1-5246db5e863c/image.png) 

# Jenkins Complete CI/CD Pipeline Environment Setup 

1) Create a GitHub Repository `realworld-cicd-pipeline-project` and push the code in this branch(main) to 
    your remote repository (your newly created repository). 
    - Go to GitHub (github.com)
    - Login to your GitHub Account
    - Create a Repository called "Jenkins-CICD-Project"
    - Clone the Repository in the "Repository" directory/folder in your local
    - Download the code in in this repository "Main branch": https://github.com/awanmbandi/eagles-batch-devops-projects.git
    - Unzip the code/zipped file
    - Copy and Paste everything from the zipped file into the repository you cloned in your local
    - Add the code to git, commit and push it to your upstream branch "main or master"
    - Confirm that the code exist on GitHub

2) Jenkins/Maven/Ansible
    - Create an Amazon Linux 2 VM instance and call it "jenkins-maven-ansible"
    - Instance type: t2.medium
    - Security Group (Open): 8080, 9100 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/eagles-batch-devops-projects/blob/maven-nexus-sonarqube-jenkins-install/jenkins-install.sh
    - Launch Instance

3) SonarQube
    - Create an Create an Ubuntu 18.04 VM instance and call it "SonarQube"
    - Instance type: t2.medium
    - Security Group (Open): 9000, 9100 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/eagles-batch-devops-projects/blob/maven-nexus-sonarqube-jenkins-install/sonarqube-install.sh
    - Launch Instance

4) Nexus
    - Create an Amazon Linux 2 VM instance and call it "Nexus"
    - Instance type: t2.medium
    - Security Group (Open): 8081, 9100 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/eagles-batch-devops-projects/blob/maven-nexus-sonarqube-jenkins-install/nexus-install.sh
    - Launch Instance

5) EC2 (Dev/Stage/Prod)
    - Create 3 Amazon Linux 2 VM instance and call them (Names: Dev-Env, Stage-Env and Prod-Env)
    - Instance type: t2.micro
    - Security Group (Open): 8080, 9100 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair

6) Prometheus
    - Create an Ubuntu 20.04 VM instance and call it "Prometheus"
    - Instance type: t2.micro
    - Security Group (Open): 9090 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - Launch Instance

7) Grafana
    - Create an Ubuntu 20.04 VM instance and call it "Grafana"
    - Instance type: t2.micro
    - Security Group (Open): 3000 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - Launch Instance

8) Slack 
    - Go to the bellow Workspace and create a Private Slack Channel and name it "yourfirstname-jenkins-cicd-pipeline-alerts"
    - Link: https://app.slack.com/client/T043JRQBB5L/C044F5PH3DE 

## Configure All Systems
### Jenkins setup
1) #### Access Jenkins
    Copy your Jenkins Public IP Address and paste on the browser = ExternalIP:8080
    - Login to your Jenkins instance using your Shell (GitBash or your Mac Terminal)
    - Copy the Path from the Jenkins UI to get the Administrator Password
        - Run: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
        - Copy the password and login to Jenkins
    - Plugins: Choose Install Suggested Plugings 
    - Provide 
        - Username: **admin**
        - Password: **admin**
        - Name and Email can also be admin. You can use `admin` all, as its a poc.
    - Continue and Start using Jenkins
    ![CompleteCICDProject!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/jenkins-signup.png)

2)  #### Plugin installations:
    - Click on "Manage Jenkins"
    - Click on "Plugin Manager"
    - Click "Available"
    - Search and Install the following Plugings "Install Without Restart"
        - **SonarQube Scanner**
        - **Prometheus metrics**
        - **CloudBees Disk Usage Simple**
        - **Slack Notification**
    - Once all plugins are installed, select **Restart Jenkins when installation is complete and no jobs are running**


3)  #### Pipeline creation
    - Click on **New Item**
    - Enter an item name: **app-cicd-pipeline** & select the category as **Pipeline**
    - Now scroll-down and in the Pipeline section --> Definition --> Select Pipeline script from SCM
    - SCM: **Git**
    - Repositories
        - Repository URL: FILL YOUR OWN REPO URL (that we created by importing in the first step)
        - Branch Specifier (blank for 'any'): */main
        - Script Path: Jenkinsfile
    - Save


4)  #### Global tools configuration:
    - Click on Manage Jenkins --> Global Tool Configuration

        **JDK** --> Add JDK --> Make sure **Install automatically** is enabled --> 
        
        **Note:** By default the **Install Oracle Java SE Development Kit from the website** make sure to close that option by clicking on the image as shown below.

        ![JDKSetup!](https://github.com/cvamsikrishna11/devops-fully-automated/blob/main/jdk_setup.png)

        * Click on Add installer
        * Select Extract *.zip/*.tar.gz --> Fill the below values
        * Name: **localJdk**
        * Download URL for binary archive: **https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz**
        * Subdirectory of extracted archive: **jdk-11.0.1**
    - **Maven** --> Add Maven --> Make sure **Install automatically** is enabled --> Install from Apache --> Fill the below values
        * Name: **localMaven**
        * Version: Keep the default version as it is 

5)  #### Credentials setup(SonarQube, Nexus, Ansible, Slack):
    - Click on Manage Jenkins --> Manage Credentials --> Global credentials (unrestricted) --> Add Credentials

        1)  ###### SonarQube secret token (sonarqube-token)
            - Kind: Secret text :
                    Generating SonarQube secret token
                    - Login to your SonarQube server (http://SonarServer-Sublic-IP:9000, with the credentials username: **admin** & password: **admin**)
                    - Click on profile --> My Account --> Security --> Tokens
                    - Generate Tokens: Fill **jenkins-token**
                    - Click on **Generate**
                    - Copy the token
            - Secret: Fill the secret token value that we have created on the SonarQube server
            - ID: sonarqube-token
            - Description: sonarqube-token
            - Click on Create

        2)  ###### Nexus username & password (nexus-credentials)
            - Kind: Username with password                  
            - Username: admin
            - Enable Treat username as secret
            - Password: admin
            - ID: nexus-credentials
            - Description: nexus-credentials
            - Click on Create    

        3)  ###### Ansible deployment server username & password (ansible-deploy-server-credentials)
            - Kind: Username with password                  
            - Username: ansadmin
            - Enable Treat username as secret
            - Password: ansadmin
            - ID: ansible-deploy-server-credentials
            - Description: ansible-deploy-server-credentials
            - Click on Create    

        4)  ###### Slack secret token (slack-token)
            - Kind: Secret text            
            - Secret: Place the Integration Token Credential ID (Note: Generate for slack setup)
            - ID: slack-token
            - Description: slack-token
            - Click on Create                 

    
6)  #### Configure system:    

        1)  - Click on Manage Jenkins --> Global Tool Configuration
            - Go to section SonarQube servers --> **Add SonarQube **
            - Name: **SonarQube**
            - Server URL: http://Replace-With-SonarQube-Server-Private-IP:9000          (replace SonarQube privat IP here)
            - Click on Save    

        2)  - Click on Manage Jenkins --> Configure System
            - Go to section Prometheus
            - Collecting metrics period in seconds: **15**
            - Click on Save

        3)  - Click on Manage Jenkins --> Configure System
            - Go to section Slack
            - Use new team subdomain & integration token credentials created in the above slack joining step
            - Workspace: **Replace with Team Subdomain value** (created above)
            - Credentials: select the slack-token credentials (created above) 
            - Default channel / member id: #general
            - Click on Save  


## ####### Observing!!!!!!!!! #######

9) Configure Promitheus
    - Login/SSH to your Prometheus Server
    - Clone the following repository: https://github.com/awanmbandi/eagles-batch-devops-projects.git
    - Change directory to "eagles-batch-devops-projects"
    - Swtitch to the "prometheus-and-grafana" git branch  
    - Run: ./install-prometheus.sh
    - Confirm the status shows "Active (running)"
    - Exit

10) Configure Grafana
    - Login/SSH to your Grafana Server
    - Clone the following repository: https://github.com/awanmbandi/eagles-batch-devops-projects.git
    - Change directory to "eagles-batch-devops-projects"
    - Swtitch to the "prometheus-and-grafana" git branch 
    - Run: ls or ll  (to confirm you have the branch files)
    - Run: ./install-grafana.sh
    - Confirm the status shows "Active (running)"
    - Exit

11) Configure The "Node Exporter" accross the "Dev", "Stage" and "Prod" instances including your "Pipeline Infra"
    - Login/SSH into the "Dev-Env", "Stage-Env" and "Prod-Env" VM instance
    - Perform the following operations on all of them
    - Install git by running: sudo yum install git -y 
    - Clone the following repository: https://github.com/awanmbandi/eagles-batch-devops-projects.git
    - Change directory to "eagles-batch-devops-projects"
    - Swtitch to the "prometheus-and-grafana" git branch 
    - Run: ls or ll  (to confirm you have the branch files)
    - Run: ./install-node-exporter.sh
    - Confirm the status shows "Active (running)"
    - Access the Node Exporters running on port "9100", open your browser and run the below
        - Dev-EnvPublicIPaddress:9100   (Confirm this page is accessible)
        - Stage-EnvPublicIPaddress:9100   (Confirm this page is accessible)
        - Prod-EnvPublicIPaddress:9100   (Confirm this page is accessible)
    - Exit

12) Configure The "Node Exporter" on the "Jenkins-Maven-Ansible", "Nexus" and "SonarQube" instances 
    - Login/SSH into the "Jenkins-Maven-Ansible", "Nexus" and "SonarQube" VM instance
    - Perform the following operations on all of them
    - Install git by running: sudo yum install git -y    (The SonarQube server already has git)
    - Clone the following repository: https://github.com/awanmbandi/eagles-batch-devops-projects.git
    - Change directory to "eagles-batch-devops-projects"
    - Swtitch to the "prometheus-and-grafana" git branch 
    - Run: ls or ll  (to confirm you have the branch files including "install-node-exporter.sh")
    - Run: ./install-node-exporter.sh
    - Make sure the status shows "Active (running)"
    - Access the Node Exporters running on port "9100", open your browser and run the below
        - Jenkins-Maven-AnsiblePublicIPaddress:9100   (Confirm the pages are accessible)
        - NexusPublicIPaddress:9100   
        - SonarQubePublicIPaddress:9100   
    - Exit

13) Update the Prometheus config file and include all the IP Addresses of the Pipeline Instances that are 
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

14) Open a New Tab on your browser for Grafana also if you've not done so already. 
    - Copy your Grafana Instance Public IP and put on the browser with port 3000 e.g "GrafanaPublic:3000"
    - Once the UI Opens pass the following username and password
        - Username: admin
        - Password: admin
        - New Username: admin
        - New Password: admin
        - Save and Continue
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

15) Update Your Jenkins file with your Slack Channel Name
    - Go back to your local, open your "Jenkins-CICD-Project" repo/folder/directory on VSCODE
    - Open your "Jenkinsfile"
    - Update the slack channel name on line "97"
    - Change name from "jenkins-cicd-pipeline-alerts" to yours
    - Add the changes to git, commit and push to GitHub
    - Confirm the changes reflects on GitHub

16) Copy your Jenkins Public IP Address and paste on the browser = ExternalIP:8080
    - Login to your Jenkins instance using your Shell (GitBash or your Mac Terminal)
    - Copy the Path from the Jenkins UI to get the Administrator Password
        - Run: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
        - Copy the password and login to Jenkins
    - Plugins: Choose Install Suggested Plugings 
    - Provide 
        - Username: admin
        - Password: admin
        - Name and Email can also be admin. You can use `admin` all through as we
    - Continue and Start using Jenkins

17) Once on the Jenkins Dashboard
    - Click on "Manage Jenkins"
    - Click on "Plugin Manager" 
    - Click "Available"
    - Search and Install the following Plugings "Install Without Restart"
        - SonnarQube Scanner
        - Maven Integration
        - Pipeline Maven Integration
        - Maven Release Plug-In
        - Slack Notification
        - Code Coverage API Plugin (Jacoco)
    - Install all plugings without restart 

18) Confirm and make test your installations/setups  
