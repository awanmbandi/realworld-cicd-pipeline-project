wget -O splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz "https://download.splunk.com/products/splunk/releases/9.0.4.1/linux/splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz"

sudo tar xvzf splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz -C /opt/

sudo adduser splunk --disabled-password

sudo chown -R splunk: /opt/splunk/

sudo su splunk

/opt/splunk/bin/splunk start

exit

sudo /opt/splunk/bin/splunk enable boot-start -user splunk



===================
download splunk universal forwarder rpm

install

sudo bash

/opt/splunkforwarder/bin/splunk start

Login to Splunk Server
Navigate to `Splunk forwarding and Receiving` and `Add Receiving Port` "9997"

Go back to your forwarding server
cd /opt/splunkforwarder/bin

/opt/splunkforwarder/bin/splunk add forward-server  Splunk-Server-Pub-IP:9997

/opt/splunkforwarder/bin/splunk restart

/opt/splunkforwarder/bin/splunk add monitor /var/log

======================

9997 for forwarders to the Splunk indexer.
8000 for clients to the Splunk Search page
8089 for splunkd (also used by deployment server).