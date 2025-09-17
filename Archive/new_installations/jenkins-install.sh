#!/bin/bash
# User-data script for Ubuntu 24.04 AWS VM
# -------------------------------
# Install Jenkins
# -------------------------------
sudo su
apt-get update -y && apt-get upgrade -y
apt-get install -y curl unzip gnupg fontconfig openjdk-11-jdk
wget https://get.jenkins.io/debian-stable/jenkins_2.375.4_all.deb
apt install -y ./jenkins_2.375.4_all.deb
apt-get install -y jenkins
systemctl enable jenkins
systemctl start jenkins 


