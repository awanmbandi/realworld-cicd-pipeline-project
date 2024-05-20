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

# Installing Git
yum install git -y

# Installing Terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install terraform -y
terraform --version

# Installing NPM and Snyk
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 15.0.0
node -e "console.log('Running Node.js ' + process.version)"
npm --version

# Installing Snyk
npm install -g snyk

# Installing Checkov
sudo pip3 install --upgrade pip
sudo pip3 install checkov
checkov --version
