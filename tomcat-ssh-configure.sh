#!/bin/bash
# Tomcat Server Installation
sudo su
amazon-linux-extras install tomcat8.5 -y
systemctl enable tomcat
systemctl start tomcat

# Provisioning Ansible Deployer Access
useradd ansibleadmin
echo ansibleadmin | passwd ansibleadmin --stdin
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "ansadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
