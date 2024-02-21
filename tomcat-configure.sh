#!/bin/bash
# Tomcat Server Installation
sudo su
amazon-linux-extras install tomcat8.5 -y
systemctl enable tomcat
systemctl start tomcat

# END


