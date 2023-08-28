## 1️⃣ Launch an Amazon Linux 2 instance and Install Jenkins
 - Jenkins Master Instance Name: `Jenkins-Master`
    - machine type: `t2.medium`
    - AMI (Image): `Amazon Linux 2`
    - Key pair: Select or Create
    - Security group ports: `8080` and `22`
    - User Data or Login and Install Jenkins: https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/jenkins-declarative-master-client-confg/runbooks/jenkins-install.md
    - Launch Instance 


## 2️⃣ Create Maven and Gradle Client/Slave Build Environments
### A) Create Your MAVEN Client Build Environment
 - Maven Instance Name: `Maven-Build-Env`
    - AMI (Image): Amazon Linux 2 (free tier) 
    - Instance type: `t2.micro`
    - Security Group (Open): `22` to `0.0.0.0/0`
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/jenkins-declarative-master-client-confg/runbooks/maven-install.md
    - Launch Instance

### B) Create Your GRADLE Client Build Environment
 - Maven Instance Name: `Gradle-Build-Env`
    - AMI (Image): Ubuntu 22.04 LTS/HVM (free tier) 
    - Instance type: `t2.micro`
    - Security Group (Open): `22` to `0.0.0.0/0`
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/jenkins-declarative-master-client-confg/runbooks/gradle-install.md
    - Launch Instance

### C) Login To Your Jenkins Master, Maven and Gradle Client & Check The JAVA Versions;
#### NOTE: The JAVA Versions Must Be The Same 
 - Jenkins JAVA Version (version 11)
 - Maven JAVA Version   (version 11)
 - Gradle JAVA Version  (version 11)

## 3️⃣ Configure Nexus
### Login to Nexus
  A) CREATE MAVEN PROJECT ARTIFACT REPOSITORY
  - Click on the Admin Repository Secition
    - Click on `Repositories`
    - Click on `Create Repository`
      - Select: `Maven2(hosted)`
      - Name: `maven-java-webapp-repository`
      - Click: `CREATE`

  B) CREATE GRADLE PROJECT ARTIFACT REPOSITORY 
  - Click on the Admin Repository Secition 
    - Click on `Repositories`
    - Click on `Create Repository`
      - Select: `Maven2(hosted)`
      - Name: `gradle-java-webapp-repository`
      - Click: `CREATE`

## UPDATE YOUR MAVEN CONFIGURATIONS
### A) Update Maven (POM.xml & Settings.xml) File
  - Switch to the <'maven-sonarqube-nexus-jenkins'> project branch
  - Update The Nexus IP Address In These Files
  - POM.xml: Line '64' and '68'
  - Settings.xml: Line '63' and '74'
  - Update The Nexus Repository As Well To Yours "if different"

### B) Update The Maven 'User Data Scrip' With Your 'settings.xml' GitHub RawLink 
 - Update the User data before Creating the Maven Build Instance/Env
 - Here: https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/jenkins-declarative-master-client-confg/runbooks/maven-install.md#2%EF%B8%8F%E2%83%A3-install-and-configure-java11-and-apache-maven

### C) Add SonarQube Scanner Snippet Configurations In Maven Project 'Jenkinsfile' File 
 - Line: '31' - '38'

## UPDATE YOUR GRADLE CONFIGURATIONS
### A) Update The Nexus IP Address & Repository Name For Gradle Project In The "build.gradle" File
 - Switch to the <'gradle-sonarqube-nexus-jenkins'>
 - Line: '57'

### B) Add The SonarQube Scanner Configurations API In The Gradle 'build.gradle' File
- Line: '37' - '44'

## 4️⃣ CONFIGURE MASTER & CLIENT CONFIGURATION
- Click on "Manage Jenkins" >> Click "Nodes and Cloud" >> Click "New Node"
- Click `New Node`
    - Node name: `Maven-Build-Env` 
    - Type: `Permanent Agent` >> Click `CREATE`

#### 4.1. Configure "Maven-Build-Env"
- Name:                  `Maven-Build-Env`
- Number of Executors:   `5` (for example, maximum jobs to execute at a time)
- Remote root directory: `/opt/maven-builds`
- Labels:                `Maven-Build-Env`
- Usage:                 `Use this node as much as possible`
- Launch method:         `Launch agents via SSH`
    - Host:   `Provide IP of Maven-Build-Server`
    - Credentials:
        - Click on `Add / Jenkins` and Select `Username and Password`
        - Username: `jenkinsmaster`
        - Password: `jenkinsmaster`
        - ID: `Maven-Build-Env-Credential`
        - Save
        - Credentials: Select `Maven-Build-Env-Credential`
    - Host Key Verification Strategy: `Non Verifying Verification Strategy`
    - Availability: `Keep this agent online as much as possible`
- NODE PROPERTIES
    - Select `Environment variables`
        - Click `Add`
        - 1st Variable:
            - Name: `MAVEN_HOME`
            - Value: `/usr/share/apache-maven`
        - 2nd Variable:
            - Name: `PATH`
            - Value: `$MAVEN_HOME/bin:$PATH`

    - Click `SAVE`
- NOTE: Make sure the `Agent Status` shows `Agent successfully connected and online` on the Logs
- NOTE: Repeat the process for adding additional Nodes

#### 4.2. Configure "Gradle-Build-Env"
- Click `New Node`
    - Node name: `Gradle-Build-Env` 
    - Type: `Permanent Agent` >> Click `CREATE`

- Name:                  `Gradle-Build-Env`
- Number of Executors:   `5` (for example, maximum jobs to execute at a time)
- Remote root directory: `/opt/gradle-builds`
- Labels:                `Gradle-Build-Env`
- Usage:                 `Use this node as much as possible`
- Launch method:         `Launch agents via SSH`
    - Host:   `Provide IP of Gradle-Build-Server`
    - Credentials:
        - Click on `Add / Jenkins` and Select `Username and Password`
        - Username: `jenkinsmaster`
        - Password: `jenkinsmaster`
        - ID: `Gradle-Build-Env-Credential`
        - Save
        - Credentials: Select `Gradle-Build-Env-Credential`
    - Host Key Verification Strategy: `Non Verifying Verification Strategy`
    - Availability: `Keep this agent online as much as possible`
- NODE PROPERTIES
    - Select `Environment variables`
        - Click `Add`
        - 1st Variable:
            - Name: `GRADLE_HOME`
            - Value: `/opt/gradle/gradle-6.8.3`
        - 2nd Variable:
            - Name: `PATH`
            - Value: `$GRADLE_HOME/bin:$PATH`

    - Click `SAVE`
- NOTE: Make sure the `Agent Status` shows `Agent successfully connected and online` on the Logs
- NOTE: Repeat the process for adding additional Nodes

## 5️⃣ Setup a CI Integration Between `GitHub` and `Jenkins`
### Navigate to your GitHub project repository
   - Open the repository
   - Click on the repository `Settings`
       - Click on `Webhooks`
       - Click `Add webhook`
           - Payload URL: http://JENKINS-PUBLIC-IP-ADDRESS/github-webhook/
           - Content type: `application/json`
           - Active: Confirm it is `Enable`
           - Click on `Add Webhook`

## 6️⃣ CREATE MAVEN PROJECT PIPELINE JOB

### 6.1. Create Maven Build, Test and Deploy Pipeline
###### Maven Build Job
- Click on `New Item`
    - Name: `Maven-Continuous-Integration-Pipeline`
    - Type: `Pipeline`
    - Click: `OK`
        - Select: `GitHub project`, Project url: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Check The Box: `GitHub hook trigger for GITScm polling`
    - Pipeline
      - Definition: Select `Git`, Repository URL: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Branches to build: `*/maven-sonarqube-nexus-jenkins`
    - Script Path: `Jenkinsfile`
    - `APPLY` and `SAVE`

## 7️⃣ CREATE GRADLE PROJECT PIPELINE JOB

### 7.1. Create Gradle Build, Test and Deploy Pipeline
###### Maven Build Job
- Click on `New Item`
    - Name: `Gradle-Continuous-Integration-Pipeline`
    - Type: `Pipeline`
    - Click: `OK`
        - Select: `GitHub project`, Project url: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Check The Box: `GitHub hook trigger for GITScm polling`
    - Pipeline
      - Definition: Select `Git`, Repository URL: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Branches to build: `*/gradle-sonarqube-nexus-jenkins`
    - Script Path: `Jenkinsfile`
    - `APPLY` and `SAVE`

## 7️⃣ TEST YOUR PIPELINE

