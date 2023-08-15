#!/bin/bash
sudo su
yum update –y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
amazon-linux-extras install epel -y
amazon-linux-extras install java-openjdk11 -y
yum install jenkins -y
echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
systemctl enable jenkins
systemctl start jenkins

# Apache Maven Installation/Config
yum update -y
yum install java-1.8.0-devel -y  # Use for Java and Maven Compiler
java --version
wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
yum install -y apache-maven

## Configure MAVEN_HOME and PATH Environment Variables
rm .bash_profile
wget https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/jenkins-master-client-config/.bash_profile
source .bash_profile
mvn -v

# Create ".m2" and download your "settings.xml" file into it to Authorize Maven
## Make sure to Update the RAW GITHUB Link to your "settings.xml" config
mkdir /var/lib/jenkins/.m2
wget https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/maven-sonarqube-nexus-jenkins-p1/settings.xml -P /var/lib/jenkins/.m2/
chown -R jenkins:jenkins /var/lib/jenkins/.m2/
chown -R jenkins:jenkins /var/lib/jenkins/.m2/settings.xml


# Installing Git
yum install git -y

# IMPORTANT:::::Make sure to set Java and Javac to Version 8 using the following commands
##### Check Maven and Java Version and Confirm it's JAVA 8
#    mvn -v
#    java -version

##### Enter the following to set Java 8 as the default runtime on your EC2 instance.
#    sudo /usr/sbin/alternatives --config java

##### Enter the following to set Java 8 as the default compiler on your EC2 instance.
#    sudo /usr/sbin/alternatives --config javac