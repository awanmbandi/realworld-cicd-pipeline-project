## 1️⃣ Launch an Amazon Linux 2 instance and Install Jenkins
- name: Jenkins-Master
- machine type: t2.medium
- image/ami: Amazon Linux 2
- Key pair: Select or Create
- Security group ports: 8080, 22
 
 ## 2️⃣ Pass As User Data or Login and Install Jenkins 
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
- Launch Your Jenkins Instance
