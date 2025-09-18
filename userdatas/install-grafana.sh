#!/bin/bash
# Update and install dependencies
sudo apt-get update -y
sudo apt-get install -y adduser libfontconfig1 wget

# Download & install Grafana
wget https://dl.grafana.com/oss/release/grafana_7.3.4_amd64.deb
sudo dpkg -i grafana_7.3.4_amd64.deb

# Reload systemd and start Grafana
sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
