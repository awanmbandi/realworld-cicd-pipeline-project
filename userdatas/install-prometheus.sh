#!/bin/bash
# Hardware requirements: AWS Linux 2 with minimum t2.micro type instance & port 9090 allowed on the security groups
# Attach a role to this Prometheus server with IAM policy as --> AmazonEC2ReadOnlyAccess

# Update & install dependencies
sudo apt-get update -y
sudo apt-get install -y git wget tar

# Create Prometheus user & directories
sudo useradd --no-create-home prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

# Download and install Prometheus
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v2.23.0/prometheus-2.23.0.linux-amd64.tar.gz
tar -xvf prometheus-2.23.0.linux-amd64.tar.gz
sudo cp prometheus-2.23.0.linux-amd64/prometheus /usr/local/bin/
sudo cp prometheus-2.23.0.linux-amd64/promtool /usr/local/bin/
sudo cp -r prometheus-2.23.0.linux-amd64/consoles /etc/prometheus/
sudo cp -r prometheus-2.23.0.linux-amd64/console_libraries /etc/prometheus/
rm -rf prometheus-2.23.0.linux-amd64.tar.gz prometheus-2.23.0.linux-amd64

# Download Prometheus config & service file from GitHub
sudo wget -O /etc/prometheus/prometheus.yml \
  https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/refs/heads/prometheus-and-grafana-install/service-discovery/prometheus.yml

sudo wget -O /etc/systemd/system/prometheus.service \
  https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/refs/heads/prometheus-and-grafana-install/service-discovery/prometheus.service

# Set permissions
sudo chown -R prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo chown -R prometheus:prometheus /var/lib/prometheus

# Start Prometheus
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
