# E-Commerce WebApp (JSP/Servlet + Maven)
![DevelopmentEnvironemntSetupProject!](https://lucid.app/publicSegments/view/ab240636-23d5-4a9b-9409-50128564c9ab/image.png)

# Development Environemnt Project
Build with `mvn clean package` and deploy `target/webapp.war` to Tomcat 9/8.5.

###### Project ToolBox 🧰
- [Git](https://git-scm.com/) Git will be used to manage our application source code.
- [Github](https://github.com/) Github is a free and open source distributed VCS designed to handle everything from small to very large projects with speed and efficiency
- [Maven](https://maven.apache.org/) Maven will be used for the application packaging and building including running unit test cases
- [SonarQube](https://docs.sonarqube.org/) SonarQube Catches bugs and vulnerabilities in your app, with thousands of automated Static Code Analysis rules.
- [Nexus](https://www.sonatype.com/) Nexus Manage Binaries and build artifacts across your software supply chain
- [EC2](https://aws.amazon.com/ec2/) EC2 allows users to rent virtual computers (EC2) to run their own workloads and applications.

## Configure Environments
1) Create a GitHub Repository
    - Navigate to https://github.com
    - Click on Repositories
    - Click on `Create` to Create a Repository
     - Repository Name: maven-sonarqube-nexus-project
     - Click on `Create`
     - Download the Project Zip from https://github.com/awanmbandi/realworld-cicd-pipeline-project/tree/maven-sonarqube-nexus
     - Unzip and Push the code to the Repository you just provisioned

2) SonarQube
    - Create an Create an Ubuntu 20.04 VM instance and call it "SonarQube"
    - Instance type: t2.medium
    - Security Group (Open): 9000 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-sonarqube-nexus-jenkins-install/sonarqube-install.sh
    - Launch Instance

3) Maven
    - Create an Amazon Linux 2 VM instance and call it "jenkins-maven-ansible"
    - Instance type: t2.micro
    - Security Group (Open): 22 to 0.0.0.0/0 or Your-IP
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-sonarqube-nexus-jenkins-install/maven-install.md
    - Launch Instance

4) Nexus
    - Create an Amazon Linux 2 VM instance and call it "Nexus"
    - Instance type: t2.medium
    - Security Group (Open): 8081 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-sonarqube-nexus-jenkins-install/nexus-install.sh
    - Launch Instance

5) Nexus
    - Create an Ubuntu 24.04 VM instance and call it "Nexus"
    - Instance type: t2.medium
    - Security Group (Open): 8081 and 22 to 0.0.0.0/0
    - Key pair: Select or create a new keypair
    - User data (Copy the following user data): https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/maven-sonarqube-nexus-jenkins-install/nexus-install-ubuntu24.04.sh
    - Launch Instance

## Configure Nexus Repository
Series of tutorial code snippets for use
#Maven publish tutorial steps
Publishing artifact to Nexus snapshot and release repo using maven.

1. Create a snapshot repo using nexus, or use default coming in out of the box. DEFAULT 
2. Create a release repo using nexus, or use default coming out of the box. DEFAULT
3. Create a group repo having both release, snapshot and other third party repos. or use default coming out of the box.
4. Download spring initializer project
5. Go settings.xml under <MAVEN_INSTALL_LOCATION>\apache-maven-3.6.0\conf or C:\Users\<USER_NAME>\.m2  or mkdir ~/.m2
6. Create/Move profiles named snapshot and release in settings.xml in `~/.m2` (can be done in pom.xml as well)
7. Add server user name and pwd in setting.xml (Encrypted recommended).
8. Edit pom.xml and add repository and snapshot repository in distribution management tag DEFAULT/DONE
9. Mark id should match in step 7 with server id of settings.xml, UPDATE NEXUS IP
10. Run the following `maven`/`mvn` commands to validate/package/deploy your app artifacts remotely
   - `mvn validate`   (validate the project is correct and all necessary information is available.)
   - `mvn compile`    (compile the source code of the project)
   - `mvn test`       (run tests using a suitable unit testing framework. These tests should not require the code be packaged or deployed.)
   - `mvn package`    (take the compiled code and package it in its distributable format, such as a WAR/JAR/EAR.)
   - `mvn verify`     (run any checks to verify the package is valid and meets quality criteria.)
   - `mvn install`    (install the package into the local repository, for use as a dependency in other projects locally.)
   - `mvn deploy`     (done in an integration or release environment, copies the final package to the remote/SNAPSHOT repository 
                      for sharing with other developers and projects.)

11. Change the version from 1.0-Snapshot to 1.0
12. Run `mvn deploy` to deploy to Snapshot Repo or `mvn clean deploy -P release`, to deploy it to Release Repo

## Maven Lifecycle Phases
- https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html#a-build-lifecycle-is-made-up-of-phases
