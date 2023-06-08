## Install and Configure Java11 and Apache Maven
```
#!/bin/bash
sudo yum update
sudo amazon-linux-extras install java-openjdk11
java --version
sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
mvn -v

## Install git
sudo yum install git -y
```

## Post Operations
```
git clone https://github.com/awanmbandi/realworld-cicd-pipeline-project.git
git checkout maven-sonarqube-nexus
```
