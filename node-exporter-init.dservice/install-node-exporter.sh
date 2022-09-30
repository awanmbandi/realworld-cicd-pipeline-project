mkdir /opt/node-exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
tar xzf node_exporter-1.0.1.linux-amd64.tar.gz
sudo cp node_exporter-1.0.1.linux-amd64/node_exporter /opt/node-exporter
rm -rf node_exporter-1.0.1.linux-amd64.tar.gz node_exporter-1.0.1.linux-amd64
sudo cp node_exporter.sh /opt/node-exporter
sudo cp node-exporter-init.d.service /etc/init.d/node_exporter
sudo chmod +x /etc/init.d/node_exporter
sudo chmod +x /opt/node-exporter/node_exporter.sh
chkconfig --add node_exporter
sudo service node_exporter start
sudo service node_exporter status

