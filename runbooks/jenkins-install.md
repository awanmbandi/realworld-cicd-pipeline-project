## 1️⃣ Launch an Amazon Linux 2 instance and Install Jenkins
- name: Jenkins-Master
- machine type: t2.medium
- image/ami: Amazon Linux 2
- Key pair: Select or Create
- Security group ports: 8080, 22
 
 ## 2️⃣ Login and Install Jenkins
 ```bash
#!/bin/bash
sudo su
yum update –y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
amazon-linux-extras install epel -y
amazon-linux-extras install java-openjdk11 -y
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins

## Installing Git
yum install git -y
 ```

## 3️⃣ Configure Master and Clinet Configuration
- Click on "Manage Jenkins" >> Click "Nodes and Cloud" >> Click "New Node"
- Click `New Node`
    - Node name: `Maven-Build-Env` 
    - Type: `Permanent Agent` >> Click `CREATE`

#### 3.1. Configure "Maven-Build-Env"
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

#### 3.2. Configure "Gradle-Build-Env"
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

## 4️⃣ CREATE MAVEN PROJECT PIPELINE JOB

### 5.1. Create Maven Build, Test and Deploy Pipeline
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

## 4️⃣ CREATE GRADLE PROJECT PIPELINE JOB

### 5.1. Create Gradle Build, Test and Deploy Pipeline
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

## 5️⃣ 6️⃣ Configure Jenkins/GitHub Webhook

### 6.1. Integrate The Maven JOBS Together To Create a CI Pipeline

### 6.2. Integrate The Gradle JOBS Together To Create a CI Pipeline

## 6️⃣ 7️⃣ TEST YOUR PIPELINE







