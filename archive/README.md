## Setup Splunk 
### A) SSH into your `Splunk Server` including `Dev`, `Stage` and `Prod` Instances to Configure Splunk
- **NOTE:** Execute and Perform all operations across all your `Dev, Stage and Prod` Environments
- **NOTE:** Run all commands and queries across all your VMs (Dev, Stage and Prod)
    - Download the Splunk RPM installer package for Linux
    ```
    wget -O splunk-9.0.4.1-419ad9369127-linux-2.6-x86_64.rpm "https://download.splunk.com/products/splunk/releases/9.0.4.1/linux/splunk-9.0.4.1-419ad9369127-linux-2.6-x86_64.rpm"
    ```
    - Install Splunk
    ```
    sudo yum install ./splunk-9.0.2-17e00c557dc1-linux-2.6-x86_64.rpm -y
    ```
    - Start the splunk server 
    ```
    sudo bash
    cd /opt/splunk/bin
    ./splunk start --accept-license --answer-yes
    ```
- Enter administrator username and password, remember this because you will need this to log into the application
- NOTE: The Password must be up to `8` characters.
    ![SplunkSetup1!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-28%20at%2010.48.24%20AM%20copy.png)

- Access your Splunk Installation at http:://3.137.207.15:8000 and log into splunk
    ![SplunkSetup2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/splunk-login-page.png)

- **NOTE:** Once you login to the splunk UI platform
    - Click on `Settings` -->> Click `Server Settings` -->> Click `General Settings`
    - Go ahead and Change the `Pause indexing if free disk space` from `5000 to 50`
    - Click on `Save`
    ![SplunkSetup3!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-29%20at%2010.34.45%20PM.png)

### Step 2: Install The Splunk Forwarder only on the `Dev, Stage and Prod` Servers
############################################################################# - **NOTE:** Use the following Forwarding
- Exit out from `root user` to `ec2-user`
```
exit
```
- Download the Splunk forwarder RPM installer package 
```
wget -O splunkforwarder-9.0.4-de405f4a7979-linux-2.6-x86_64.rpm "https://download.splunk.com/products/universalforwarder/releases/9.0.4/linux/splunkforwarder-9.0.4-de405f4a7979-linux-2.6-x86_64.rpm"
```
- Install the Forwarder
```
ls -al
sudo yum install ./splunkforwarder-9.0.4-de405f4a7979-linux-2.6-x86_64.rpm -y
```

- Change to the splunkforwarder bin directory and start the forwarder
- NOTE: The Password must be at least `8` characters long.
- Set the port for the forwarder to ``9997``, this is to keep splunk server from conflicting with the splunk forwarder
```
sudo bash
cd /opt/splunkforwarder/bin
./splunk start --accept-license --answer-yes
```

![SplunkSetup2!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-28%20at%2011.31.42%20AM.png)

- Set the forwarder to forward to the splunk server on port ``9997``, and will need to enter username and password (change IP address with your own server IP address). When prompted for username and password, enter what you set above for username and password.
```
./splunk add forward-server SPLUNK-SERVER-Public-IP-Address:9997
```

- Restart Splunk on the VM you are configuring the Forwarder
```
./splunk restart
```

- Set the forwarder to monitor the ``/var/log/tomcat/`` directory and restart
```
./splunk add monitor /var/log/tomcat/
```

- Set the port for the splunk server to listen on 9997 and restart
```
cd /opt/splunk/bin
./splunk enable listen 9997
```
![SplunkSetup3!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/raw/zdocs/images/Screen%20Shot%202023-04-29%20at%2010.55.36%20PM.png)
