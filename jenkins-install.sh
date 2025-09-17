#!/bin/bash
# Userdata script for Ubuntu 24.04 AWS VM
# ----------------------------------------
# Install Jenkins
# ----------------------------------------
sudo su
sudo apt-get update -y && apt-get upgrade -y
sudo apt-get install -y curl unzip gnupg fontconfig openjdk-17-jre
sudo apt-get install -y openjdk-11-jdk
sudo curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | \
  tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# ----------------------------------------
# Change The Java Version to JAVA11
# ----------------------------------------
# Find the path of Java 11
JAVA11_PATH=$(update-alternatives --list java | grep "java-11")
# Set Java 11 as the default
update-alternatives --set java "$JAVA11_PATH"
update-alternatives --set javac "$(dirname $JAVA11_PATH)/javac"

# ----------------------------------------
# Installing Apache Maven
# ----------------------------------------
sudo apt-get install maven -y
mvn -v

# ----------------------------------------
# Install and Configure Ansible
# ----------------------------------------
# Create ansible user with sudo privileges
# sudo useradd -m -s /bin/bash ansible
sudo useradd ansible -m 
echo 'ansible:ansible' | sudo chpasswd
sudo usermod -aG sudo ansible

# Give user Authorization | Without Needing Password
sudo EDITOR='tee -a' visudo << 'EOF'
ansible ALL=(ALL) NOPASSWD:ALL
EOF

# Update the sshd_config Authentication file (Password and SSH)
sudo sed -i 's@^#\?PasswordAuthentication .*@PasswordAuthentication yes@' /etc/ssh/sshd_config
sudo sed -i '/^PasswordAuthentication yes/a ChallengeResponseAuthentication yes' /etc/ssh/sshd_config
sudo systemctl restart ssh

# Update system packages
sudo apt update && sudo apt upgrade -y
# Install the necessary software-properties-common package:
sudo apt install -y software-properties-common
# Add the Ansible PPA (Personal Package Archive) to your system:
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Install Ansible using apt:
sudo apt update -y
sudo apt install -y ansible
# Verify Ansible installation
ansible --version

# Update the ansible config file
sudo tee -a /etc/ansible/ansible.cfg > /dev/null <<EOF
[defaults]
inventory = /etc/ansible/hosts
remote_user = ansible
host_key_checking = False
EOF

# ----------------------------------------
# Installing Git
# ----------------------------------------
sudo apt install git -y

