## MAVEN BUILD ENVIRONMENT
## AMI: Amazon Linux 2
## Provision Jenkins Master Access
sudo su
useradd jenkinsmaster 
echo jenkinsmaster | passwd jenkinsmaster --stdin ## Amazon Linux
# Enable Password Authentication and Authorization
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "jenkinsmaster ALL=(ALL)" >> /etc/sudoers
chown -R jenkinsmaster:jenkinsmaster /opt


## GRADLE BUILD ENVIRONMENT
## AMI: Ubuntu 18.04 LTS HVM
## Provision Jenkins Master Access
sudo su
useradd jenkinsmaster -m
echo "jenkinsmaster:jenkinsmaster" | chpasswd  ## Ubuntu
# Enable Password Authentication and Authorization
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "jenkinsmaster ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chown -R jenkinsmaster:jenkinsmaster /opt