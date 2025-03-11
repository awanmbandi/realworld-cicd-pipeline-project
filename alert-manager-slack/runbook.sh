################################ STEP ONE ################################

## Download Alert Manager Config
sudo wget PROVIDE_YOUR_ALERT_MANAGER_CONFIG_RAW_URL -P /etc/prometheus/

## Download Alert Manager Rule Set
sudo wget PROVIDE_YOUR_ALERT_MANAGER_RULES_CONFIG_RAW_URL -P /etc/prometheus/

## Replace Promethus config
sudo wget PROVIDE_YOUR_PROMETHEUS_CONFIG_RAW_URL -P /etc/prometheus/


################################ OR! OR! OR! ################################
## Download Alert Manager Config
sudo vi /etc/prometheus/alertmanager.yml

## Download Alert Manager Rules config
sudo vi /etc/prometheus/prometheus_alert_rules.yml

## Replace Promethus config
sudo vi /etc/prometheus/prometheus.yml


################################ OR! OR! OR! ################################
## Download Alert Manager Config
sudo wget https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/refs/heads/prometheus-and-grafana-install/alert-manager-slack/alertmanager.yml -P /etc/prometheus/

## Download Alert Manager Rule Set
sudo wget https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/refs/heads/prometheus-and-grafana-install/alert-manager-slack/prometheus_alert_rules.yml -P /etc/prometheus/

## Replace Promethus config
sudo wget https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/refs/heads/prometheus-and-grafana-install/alert-manager-slack/prometheus.yml -P /etc/prometheus/


################################ STEP TWO ################################
sudo systemctl restart prometheus



################################ STEP THREE ################################
#!/bin/bash
# Step 1: Download and Install Alertmanager
wget https://github.com/prometheus/alertmanager/releases/download/v0.26.0/alertmanager-0.26.0.linux-amd64.tar.gz
tar xvf alertmanager-0.26.0.linux-amd64.tar.gz
sudo mv alertmanager-0.26.0.linux-amd64/alertmanager /usr/local/bin/
alertmanager --version

# Step 2: Create a Systemd Service for Alertmanager
sudo tee /etc/systemd/system/alertmanager.service > /dev/null <<EOL
[Unit]
Description=Prometheus Alertmanager
After=network.target

[Service]
User=prometheus
Group=prometheus
ExecStart=/usr/local/bin/alertmanager \
    --config.file=/etc/prometheus/alertmanager.yml \
    --storage.path=/var/lib/alertmanager
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Step 3: Set Up Permissions and Directories
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir -p /var/lib/alertmanager
sudo chown prometheus:prometheus /var/lib/alertmanager
sudo mkdir -p /etc/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /etc/prometheus/alertmanager.yml

# Step 4: Start and Enable Alertmanager
sudo systemctl daemon-reload
sudo systemctl start alertmanager
sudo systemctl enable alertmanager
sudo systemctl status alertmanager

