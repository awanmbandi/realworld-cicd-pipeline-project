## RESOURCE CREATION ORDER
1. Create Nexus and SonarQube VMs
2. Open Nexus on the browser
  - Create the Maven `Snapshot` and `Release` repositories
  - Update POM.xml and SETTINGS.xml with Nexus values (URLs and CREDENTIALS)
  - Update Jenkins Installation SETTINGS.xml RAW script URL
  - PUSH Chnages to GITHUB

3. Create Jenkins VM
  - Pass Userdata to install Jenkins
  - RUN MANUAL COMMANDS to setup and configure MAVEN from `manual-maven-install.sh` = https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/jenkins-maven-sonarqube-nexus/Archive/manual-maven-install.sh 

## THINGS TO UPDATE BEFORE 
1. Update the Jenkinsfile (SonarQube Configs)
2. Update the POM.XMl file (Nexus Repositories)
3. Update the SETTINGS.XML file (Nexus Username and Password, Nexus Repositories)
4. Update Jenkins/Maven JAVA version to JAVA 11

## Maven + SonarQube 
mvn clean sonar:sonar \
  -Dsonar.projectKey=JavaWebApp \
  -Dsonar.host.url=http://44.203.4.255:9000 \
  -Dsonar.login=<sonarqube prject token>




