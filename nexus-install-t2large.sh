#!/bin/bash

# Update package list
sudo apt update -y

# Install OpenJDK 17
sudo apt install openjdk-17-jdk -y

# Verify Java installation
java --version

# Download the latest Nexus tarball to /opt
sudo wget https://download.sonatype.com/nexus/3/nexus-unix-x86-64-3.78.1-02.tar.gz -O /opt/latest-unix.tar.gz

# Extract the tarball
sudo tar -xvzf /opt/latest-unix.tar.gz -C /opt

# Rename the extracted directory to /opt/nexus
# Note: The exact version number may vary; using a wildcard to handle this
sudo mv /opt/nexus-3.* /opt/nexus

# Create a nexus user non-interactively
sudo adduser --disabled-password --gecos "" nexus

# Grant the nexus user sudo privileges without a password
sudo su
echo "nexus ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# Change ownership of nexus directories
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work

# Configure the nexus.rc file to run as the nexus user
echo 'run_as_user="nexus"' | sudo tee /opt/nexus/bin/nexus.rc

# Append JVM options to nexus.vmoptions
cat <<EOL | sudo tee -a /opt/nexus/bin/nexus.vmoptions
-XX:MaxDirectMemorySize=2703m
-Djava.net.preferIPv4Stack=true
EOL

# Create the systemd service file for Nexus
cat <<EOL | sudo tee /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd, start, and enable the Nexus service
sudo systemctl daemon-reload
sudo systemctl start nexus
sudo systemctl enable nexus

# Check the status of the Nexus service
sudo systemctl status nexus

# Allow Nexus default port (8081) through the firewall
sudo su
ufw allow 8081/tcp
