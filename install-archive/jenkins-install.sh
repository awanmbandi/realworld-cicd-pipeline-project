#!/bin/bash
# Update the system
yum update -y
# Install Java 17 (Amazon Corretto)
amazon-linux-extras enable corretto17
yum install -y java-17-amazon-corretto-devel
# Add Jenkins repository
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
# Install Jenkins
yum install -y jenkins
# Start and enable Jenkins service
systemctl enable jenkins
systemctl start jenkins
# Wait for Jenkins to initialize
echo "Waiting for Jenkins to start..."
sleep 30
# Retrieve and display initial admin password
echo "Jenkins initial admin password:"
cat /var/lib/jenkins/secrets/initialAdminPassword 2>/dev/null || echo "Password file not ready yet. Try again in a few minutes."
# Optional: Open firewall port 8080 if using firewalld
# systemctl status firewalld >/dev/null 2>&1
# if [ $? -eq 0 ]; then
#     firewall-cmd --permanent --add-port=8080/tcp
#     firewall-cmd --reload
# fi
echo "Setup complete!"
echo "Access Jenkins at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):8080"

# Installing Git
yum install git -y

# Installing Ansible
amazon-linux-extras install ansible2 -y
yum install python-pip -y
pip install boto3

# Provisioning Ansible Deployer Access
useradd ansibleadmin
echo ansibleadmin | passwd ansibleadmin --stdin
sed -i "s/.*#host_key_checking = False/host_key_checking = False/g" /etc/ansible/ansible.cfg
sed -i "s/.*#enable_plugins = host_list, virtualbox, yaml, constructed/enable_plugins = aws_ec2/g" /etc/ansible/ansible.cfg
ansible-galaxy collection install amazon.aws

# Enable Password Authentication and Grant Sudo Privilege
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "ansibleadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Apache Maven Installation/Config
#sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
#sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
#sudo yum install -y apache-maven
#sudo yum install java-1.8.0-devel

#sudo /usr/sbin/alternatives --config java
#sudo /usr/sbin/alternatives --config javac

# Use The Amazon Linux 2 AMI When Launching The Jenkins VM/EC2 Instance
# Instance Type: t2.medium or small minimum
# Open Port (Security Group): 8080 
