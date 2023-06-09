## 1.0 Launch an Amazon Linux 2 instance and Configure Jenkins
- name: Jenkins-Master
- machine type: t2.medium
- image/ami: Amazon Linux 2
- Key pair: Select or Create
- Security group ports: 8080, 22
 
 ### Login and Install Jenkins
 ```
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

### Configure Master and Clinet Configuration
- Click on "Manage Jenkins" >> Click "Nodes and Cloud" >> Click "New Node"
- Click `New Node`
    - Node name: `Maven-Build-Env` 
    - Type: `Permanent Agent` >> Click `CREATE`

#### 1. Configure "Maven-Build-Env"
- Name:                  `Maven-Build-Env`
- Number of Executors:   `5` (for example, maximum jobs to execute at a time)
- Remote root directory: `/opt/maven-builds`
- Labels:                `Maven-Build-Env`
- Usage:                 `Use this node as much as possible`
- Launch method:         `Launch agents via SSH`
    - Host:   `Provide IP of Maven-Build-Server`
    - Credentials: 
        - Login to `Maven VM`
        - Run the following commands
            - sudo su
            - passwd root
            - provide the password as "root", "root"
            - vi /etc/ssh/sshd_config       (:/PasswordAuthentication)
            - systemctl restart sshd
    - Credentials:
        - Click on `Add / Jenkins` and Select `Username and Password`
        - Username: `root`
        - Password: `root`
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

#### 2. Configure "Gradle-Build-Env"
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
        - Login to `Gradle VM`
        - Run the following commands
            - sudo su
            - passwd root
            - provide the password as "root", "root"
            - vi /etc/ssh/sshd_config       (:/PasswordAuthentication)
            - systemctl restart sshd
    - Credentials:
        - Click on `Add / Jenkins` and Select `Username and Password`
        - Username: `root`
        - Password: `root`
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
            - Value: `/opt/gradle-6.8.3`
        - 2nd Variable:
            - Name: `PATH`
            - Value: `$GRADLE_HOME/bin:$PATH`

    - Click `SAVE`
- NOTE: Make sure the `Agent Status` shows `Agent successfully connected and online` on the Logs
- NOTE: Repeat the process for adding additional Nodes

## Plugin Installation Before Job Creation
- Install: `Delivery Pipeline` plugin
    - Click on `Dashboard` on Jenkins
    - Click on The `+` on your Jenkins Dashboard and Configure the View
    - Select ``Enable start of new pipeline build``
    - Pipelines >> Components >> Click `Add`
        - Name: `Maven-Continuous-Integration-Pipeline` or `Gradle-Continuous-Integration-Pipeline`
        - Initial Job: Select either the `Maven Build Job or 1st Job` or `Gradle Build Job or 1st Job`
    - APPLY and SAVE

## CREATE PIPELINE JOBS

### 1. Create Maven Build, Test and Deploy Job

### 2. Create Gradle Build, Test and Deploy Job

## JOB INTEGRATION

### Integrate The Maven JOBS Together To Create a CI Pipeline

### Integrate The Gradle JOBS Together To Create a CI Pipeline

## TEST YOUR PIPELINE







