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
