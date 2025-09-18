#!/bin/bash
# Install Node Exporter on Ubuntu/Debian

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
