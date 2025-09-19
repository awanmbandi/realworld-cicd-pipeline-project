#!/bin/bash
# ----------------------------------------
# Install and Configure Apache Tomcat
# ----------------------------------------
apt-get update -y
apt-get upgrade -y

# Install Java (Tomcat needs Java)
apt-get install -y openjdk-17-jdk wget curl tar

# Set JAVA_HOME
JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
echo "JAVA_HOME=${JAVA_HOME}" >> /etc/environment
source /etc/environment

# Download Tomcat (latest stable Tomcat 10.x)
cd /opt
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.46/bin/apache-tomcat-10.1.46.tar.gz

# Extract and rename
tar xzvf apache-tomcat-10.1.46.tar.gz
mv apache-tomcat-10.1.46 tomcat
rm apache-tomcat-10.1.46.tar.gz

# Set permissions
chown -R ubuntu:ubuntu /opt/tomcat
chmod +x /opt/tomcat/bin/*.sh

# Create systemd service
cat <<EOF >/etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat 10 Web Application Container
After=network.target

[Service]
Type=forking

User=ubuntu
Group=ubuntu

Environment=JAVA_HOME=${JAVA_HOME}
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start Tomcat
systemctl daemon-reload
systemctl enable tomcat
systemctl start tomcat

# Add admin user to tomcat-users.xml
sed -i '/<\/tomcat-users>/i \
<role rolename="admin-gui"/>\n\
<role rolename="admin-script"/>\n\
<user username="admin" password="StrongPassword123" roles="admin-gui,admin-script"/>' /opt/tomcat/conf/tomcat-users.xml

# Remove the RemoteAddrValve line in host-manager
sed -i '/RemoteAddrValve/d' /opt/tomcat/webapps/host-manager/META-INF/context.xml

# Remove the RemoteAddrValve line in manager
sed -i '/RemoteAddrValve/d' /opt/tomcat/webapps/manager/META-INF/context.xml

# Restart The Tomcat Application
sudo systemctl restart tomcat

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

# ----------------------------------------
# Install and Configure Node Exporter
# ----------------------------------------
# Create node_exporter user
sudo useradd --no-create-home node_exporter

# Download and install Node Exporter
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
tar xzf node_exporter-1.0.1.linux-amd64.tar.gz
sudo cp node_exporter-1.0.1.linux-amd64/node_exporter /usr/local/bin/
rm -rf node_exporter-1.0.1.linux-amd64*

# Download service file directly from GitHub (instead of assuming it exists locally)
sudo wget -O /etc/systemd/system/node-exporter.service \
  https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/refs/heads/prometheus-and-grafana-install/node-exporter.service

# Reload systemd and enable/start Node Exporter
sudo systemctl daemon-reload
sudo systemctl enable node-exporter
sudo systemctl start node-exporter

