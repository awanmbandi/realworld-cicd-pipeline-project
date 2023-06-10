1. Create VMs and Pass User Data Script
- Jenkins Master
- Maven
- Gradle
- SonarQube (Everyone should check if they already have, if not create)
- Nexus (Everyone should check if they already have, if not create)

2. Post VM Configurations 
## SonarQube
- SonarQube: Sign in on Web portal
- SonarQube: Create `2` Projects, One for Maven and One for Gradle
    - First Project: `Maven-Java-Webapp-Sonar-Analysis` 
    - Second Project: `Gradle-Java-Webapp-Sonar-Analysis` 
- Save Credentials and Pass in `gradle.build` and `maven test job`

## Nexus 
- Nexus: Sign into Nexus portal
- Nexus: Create `2` repositories
    - First Repo: `maven-java-webapp-repository` 
    - Second Repo: `gradle-java-webapp-repository` 
- Nexus: Update the  `gradle.build` and maven `pom.xml` and `settings.xml`
- Nexus: Push Changes to GitHub

## MAKE SURE TO CONFIGURE THE ABOVE AND PUSH CHANGES TO GITHUB BEFORE CONTINUING

## Maven
- Maven: `sudo su`
- Maven: Confirm JAVA and Maven is Configured Properly
- Maven: Password the Root User with a New Password "root"
- Maven: Edit the "/etc/ssh/sshd_config" file and provide `PermitRootLogin yes` and `PasswordAuthentication yes` Access
- Maven: `systemctl restart sshd`
- Maven: Perform a Test Login with `Root Username` and `Password`

## Gradle
- Gradle: `sudo su`
- Gradle: Confirm JAVA and Gradle is Configured Properly
- Gradle: Password the Root User with a New Password "root"
- Gradle: Edit the "/etc/ssh/sshd_config" file and provide `PermitRootLogin yes` and `PasswordAuthentication yes` Access
- Gradle: `systemctl restart sshd`
- Gradle: Perform a Test Login with `Root Username` and `Password`

## Jenkins
- Jenkins: Sign in on Portal
- Jenkins: Integrate Nodes 
- Jenkins: Confirm Integration
- Jenkins: Create all `3 Maven Jobs`
- Jenkins: Create all `3 Gradle Jobs`
- Jenkins: Integrate all `3 Maven Jobs`
- Jenkins: Integrate all `3 Gradle Jobs`
- Jenkins: Install `Continuous Delivery` Pipeline Plugin
- Jenkins: Configure `Continuous Delivery` View for Maven Project
- Jenkins: Configure `Continuous Delivery` View for Gradle Project

## Test Pipeline


