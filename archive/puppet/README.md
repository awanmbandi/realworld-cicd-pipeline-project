## Puppet Official Installation Page For All Installers
- https://www.puppet.com/docs/pe/2021.7/installing_pe.html
- https://www.puppet.com/downloads/puppet-enterprise?_ga=2.27784444.1130854862.1687842708-1333680495.1687659552&_gl=1%2A5p1ud5%2A_ga%2AMTMzMzY4MDQ5NS4xNjg3NjU5NTUy%2A_ga_7PSYLBBJPT%2AMTY4NzkwNDA5MS44LjEuMTY4NzkwNTkyMi4xMC4wLjA.

## Perform Installation and Configuration of PE on Ubuntu 20.04 LTS
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
```
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

## Perform Installation and Configuration of PE on Ubuntu 18.04 LTS
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

## Second Installation
- Run the Puppet Enterprise(PE) installation script again
    - This time seletect `2`
```
sudo ./puppet-enterprise-installer
```
- This time seletect `2`
