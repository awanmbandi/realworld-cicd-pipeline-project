## Launch Maven Environment and Configure
- Name: Maven-Build-Env
- AMI: Amazon Linux 2
- Instance type: t2.micro
- Security group ports: 22

## Install and Configure Java11 and Apache Maven
```
#!/bin/bash
sudo su
yum update
amazon-linux-extras install java-openjdk11
java --version
wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
yum install -y apache-maven

echo "MAVEN_HOME=/usr/share/apache-maven" >> .bash_profile
echo "PATH=$MAVEN_HOME/bin:$PATH" >> .bash_profile
source .bash_profile
mvn -v

## Install git
yum install git -y

## Download settings.xml into .m2 for Authorization
mkdir /root/.m2
wget https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/maven-sonarqube-nexus-jenkins/settings.xml -P /root/.m2/
```

## Password your `Root User: root` and Edit the `sshd_config` for Authentication
- Username: root
- Password: root
- sshd_config: Edit `PermitRootLogin yes` and `PasswordAuthentication yes` 
- Save File
```
sudo su
passwd root
vi /etc/ssh/sshd_config
systemctl restart sshd

exit
ssh root@MAVEN_VM_PUBLIC_IP
```

## Post Operations (Only Neccessary If You Must Test The Environment Before Integrating Jenkins)
```
git clone https://github.com/awanmbandi/realworld-cicd-pipeline-project.git
git checkout maven-sonarqube-nexus
```
