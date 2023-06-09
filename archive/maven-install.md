## Install and Configure Java11 and Apache Maven
```
#!/bin/bash
sudo yum update
sudo amazon-linux-extras install java-openjdk11
java --version
sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven

echo MAVEN_HOME=/usr/share/apache-maven >> .bash_profile
echo PATH=$MAVEN_HOME/bin:$PATH >> .bash_profile
source .bash_profile
mvn -v

## Install git
sudo yum install git -y
```

## Create The ".m2" Directory and Download Your "settings.xml" file to it to provide Maven Authourization to Nexus
```
sudo su
mkdir .m2
wget wget https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/maven-sonarqube-nexus-jenkins/settings.xml -P /root/.m2/
```

## Post Operations (Only Neccessary If You Must Test The Environment Before Integrating Jenkins)
```
git clone https://github.com/awanmbandi/realworld-cicd-pipeline-project.git
git checkout maven-sonarqube-nexus
```
