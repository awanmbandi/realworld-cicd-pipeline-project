## Puppet Official Installation Page For All Installers
- https://www.puppet.com/docs/pe/2021.7/installing_pe.html
- https://www.puppet.com/downloads/puppet-enterprise?_ga=2.27784444.1130854862.1687842708-1333680495.1687659552&_gl=1%2A5p1ud5%2A_ga%2AMTMzMzY4MDQ5NS4xNjg3NjU5NTUy%2A_ga_7PSYLBBJPT%2AMTY4NzkwNDA5MS44LjEuMTY4NzkwNTkyMi4xMC4wLjA.

## Perform Installation and Configuration of PE on Ubuntu 20.04 LTS
#### Pre-requisites
- Once you login to the Puppet Enterprise Master Add the Following in /etc/hosts
- Add the Following in `/etc/hosts` `Private IP of Master     puppet`, ****VERIFY IF THIS IS TRUE*****
```
sudo vi /etc/hosts
```
- **Task 1:** SSH into Your Ubuntu 20.04 VM
```
ssh -i PRIVATE_KEY_FILE USERNAME@HOST_IP
```
- **Task 2:** Download The latest .TAR.GZ for Ubuntu 20.04
```
wget --content-disposition 'https://pm.puppet.com/cgi-bin/download.cgi?dist=ubuntu&rel=20.04&arch=amd64&ver=latest'
```
- **Task 3:** Untar the TAR file 
```
tar -xf 
```
- **Task 4:** Run the PE Installer Config Script
```
sudo ./puppet-enterprise-installer
```
- **Task 5:** Configure and Setup PE Console Password
- **NOTE:** Provide PASSWORD as `adminadmin` for example
```
sudo -i
puppet infrastructure console_password
```
- **Task 6:** Finalize PE Configuration by Running the Following Command `TTWICE`
```
puppet agent -t
puppet agent -t
```

- **Task 7:** Access the Puppet Enterprise Console
    - It's default Ports are `80` and `443`
    - Copy and Paste the External/Public DNS or IP on the browser
```
https://d27a2a3cb12c.mylabserver.com
```

- **Task 8:** Provide Username and Password
```
Default Username: admin
Password (We gave): adminadmin
```

- Once you Provide Your Username and Password, It'll Log You Into The PE Console
![PEConsole!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-06-27%20at%207.21.53%20PM.png)

### NOTE (TROUBLESHOOTING): IF You End Up Stoping Your Instances and For Some Reason PE Wouldn't Come Up After A Restart 
1. You might just need to give it some time, especially if it's a `Bad Gateway Error`
2. But if on your browser, there's no Bad Gateway error, it just breaks, not loading, you see firewalls etc then go ahead and run the following commands to stop and restart some of the core services in your Puppet Enterprise setup.  
```
sudo systemctl stop pe-puppetdb
sudo systemctl stop pe-puppetserver
sudo systemctl stop pe-console-services
```
- *START THE BACK*
```
sudo systemctl start pe-puppetdb
sudo systemctl start pe-puppetserver
sudo systemctl start pe-console-services
```

## ADD MANAGE NODES TO YOUR PUPPET ENTERPRISE MASTER (OF MASTERS)
1. SSH into your Puppet Enterprise Master Node (If you have not already)
2. Add your first Puppet Agent Node by add its `Private IP into /etc/hosts`
```
sudo vi /etc/hosts
```
- NOTE: It should look like this `Private IP      puppet`

3. SSH Into your `First/Second/Third etc Agent Node` 
4. Do the same thing, ADD the Puppet Master `Private IP into /etc/hosts`
```
sudo vi /etc/hosts
```
- NAVIGATE BACK TO MASTER: Go to your PE Management Console
    - Click on on `Node Groups` >>> Click on `PE Master` >>> `Classes`
        - Add a Class Repository for your Agent Node OS if different from Master Node OS
            - Example, for `CentOs Class`:  Is `pe_repo::platform::el_7_x86_64`
            - Click `Add Class`
            - Click on `Commit 1 Change` bottom right of your screen
    - Click on `Nodes`
        - Click on the `Master Node/Host Name or IP`
        - Click at the Top Right `RUN` >> Click `Puppet` >> `Confirm Bottom Right` (We need to Run Puppet for the `Repository Class` Consifuration to get applied)
    ![ConfirmPEMrepositoryClassInstall!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-06-28%20at%2012.22.17%20AM.png)

    - Click back on `Nodes` >> Click `Install Agent` 
        - Copy Command under `Advanced installation` and Run in `Agent Node`
        ```
        curl -k https://d27a2a3cb12c.mylabserver.com:8140/packages/current/install.bash | sudo bash
        ```
        - NOTE: Confirm and MAKE sure the Command ran successfully
5. Run the Following Command on the PE Master to get the `Fingerprint`.
 ```
sudo puppet agent --fingerprint
 ```
6. Also Run the same command on `Agent Nodes` and confirm the `Fingerprint`. It'll be different from that of your PE Master.
 ```
sudo puppet agent --fingerprint
 ```
 7. Now navigate back to your `PE Master Management Console`
    - Click on `Certificates`
    - Refresh `your screen`
        - Click on `UNSIGNED CERTIFICATES`
        - Confirm the `New Node Name` that you're adding and the `Fingerprint of the Node`, must match what you receieved at the level of the Agent Node. Once confirmed....
        - Click on `Accept`
    ![ConfirmAgentFingerprintSuccess!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-06-28%20at%2012.40.37%20AM.png)

    - Confirm that Node has been added. Click on `Nodes`
    ![ConfirmPEMagentIntegration!](https://github.com/awanmbandi/realworld-cicd-pipeline-project/blob/zdocs/images/Screen%20Shot%202023-06-28%20at%2012.48.32%20AM.png)



## In other for our Puppet Master and Agent to Communicate 
- They need to exchange Hand Shakes
- We need to make sure the Master Has the Certificate needed provided by `Puppet Enterprise CA`
- We also need to make sure there's no MAN-IN-THE-MIDDLE Attach going on
- We also need to make sure we're accepting the right Agent Node

 1. Run the Following Command on the PE Master to get the `Fingerprint and Compare` with the Fingerprint the Master Received.
 ```
sudo puppet agent --fingerprint
 ```
 - **RESULT:** (SHA256) 52:61:AF:B2:BC:BA:9D:D5:91:F2:B9:54:4E:60:B2:D9:89:37:16:A8:A3:3A:BC:ED:34:94:00:97:A8:31:E6:73

 2. 

 curl -k https://d27a2a3cb12c.mylabserver.com/packages/current/install.bash | sudo bash























### Perform Installation and Configuration of PE on Ubuntu 18.04 LTS
- Operating System: Ubuntu 18.04 LTS Beaver amd64
- Pull down the appropriate .TAR.GZ Puppet Install File
```
wget --content-disposition 'https://pm.puppetlabs.com/puppet-enterprise/2018.1.7/puppet-enterprise-2018.1.7-ubuntu-18.04-amd64.tar.gz'
```

- Untar the tar file
```
tar -xf puppet-enterprise-2018.1.7-ubuntu-18.04-amd64.tar.gz
```
- Navigate into the unzipped directory and check whats inside
```
cd puppet-enterprise-2018.1.7-ubuntu-18.04-amd64/
ls -al
```

- Install Puppet Enterprise
```
sudo ./puppet-enterprise-installer
```
- Once Prompted to select either of `Test Mode` or `Graphical Mode` 
```
select 1, by typing 1
```


- You will be asked to set your Console password where you have `console_admin_password`, Pass `admin`
    - In this Puppet Enterprise Configuration file this is where you can provide all the Customization you want for your solution
    - This is where you define the Puppet Split Multi Master Architecture meaning `Master Of Master Configuration`
    - You can as well configure a separate/segregated Puppet Enterprise Datase use by your Puppet Enterprise Host/Solution

```
console_admin_password: "admin"
```
- Once you add the `admin` password, Save and Quite the file with `:wq!`
- It'll as you to Proceed with installation using the pe.conf: Type `n`

### Second Installation
- Run the Puppet Enterprise(PE) installation script again
    - This time seletect `2`
```
sudo ./puppet-enterprise-installer
```
- This time seletect `2`



## Important Documentations
1. What Get Installed: https://www.puppet.com/docs/pe/2023.2/what_gets_installed_and_where.html#certificates_installed
2. Install and Setup Agent Nodes in PEM: https://www.puppet.com/docs/pe/2023.2/install_agent_console.html#install_agent_console
3. Install Puppet Enterprise Master (PEM): https://www.puppet.com/downloads/puppet-enterprise




Install agent on nodes
Install agents on target nodes and create certificate signing requests. After certificates are signed, nodes report information to PuppetDB and become available to use in the console. You can install agents using the console or manually on the command line.