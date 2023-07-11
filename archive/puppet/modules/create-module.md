## Navigate to the Puppet Environment Module Directory
```
cd /etc/puppetlabs/code/environments
ls -al
mkdir development 
mkdir stagging 
cd production
```

## Directories and Files Meaning
1. The `environment.conf` caries and containes all the environmental settings of this puppet managed environment
- We do not have to touch this to utilize this environment
```
cat environment.conf
```

2. The `hiera.yaml`, Hiera is a built-in key-value configuration data lookup system, used for separating data from Puppet code. 
- Puppet's strength is in reusable code. 
- Code that serves many needs must be configurable: put site-specific information in external configuration data files, rather than in the code itself.
```
cat hiera.yaml
```

3. The `manifest` directory, contains Puppet configuration language that describes how resources should be configured. 
- The manifest is the closest thing to what one might consider a Puppet program. 
- It declares resources that define state to be enforced on a node.
- It's currently empty because we haven't configured any `Desired Configuration Module` 

4. The next thing is, we need to provision our Module. 
- There are two ways to go about it you have the `Manual Approach` and the `Puppet Dev Kit (PDK)` approach.

- **NOTE:** The `Puppet Dev Kit (PDK)` approach enables you to create a Puppet Module Skeleton by generating all the Data Files and Directories that are needed to design a well refined and production grade module for any Engagement.
- **NOTE:** We need to Install the `PDK` first before we could use it.
```bash
sudo dpkg --configure -a
sudo apt-get install pdk -y
```

### We Need To Create Our First Module (NGINX)
1. Create The `Nginx` Module
```bash
sudo su
cd manifests
pdk new module nginx
```

#### Answer Questions Posted From The Above Command
```
- [Q 1/4] If you have a Puppet Forge username, add it here. 
Hit Enter and Leave Default Settings. Leave Default User

- [Q 2/4] Who wrote this module?
Put Your Name here, Example: Mbandi AAK

- [Q 3/4] What license does this module code fall under?
Hit Enter and Leave Default Settings

- [Q 4/4] What operating systems does this module support?
Only Enable RedHat and Debian
Disable/Unselect Windows by putting your arrow on the Windows Option and ``Hit Space Bar Key``
⬢ 1) RedHat based Linux
⬢ 2) Debian based Linux
```

#### Now Your Module Has Been Created, Verify by running `ls and cd` into the Newly created Module
- It will generate a number of configurations that includes files and directories but we're not going to use it all 
- The `data` directory is configured with Hiera inteligence and configuration, it's responsible to managing our heira data for this Module
- The `files` directory is where we'll store any files that will need to be sent to the target nodes based on the `new module`.
- The `manifest` directory will store the actual configurations that ends with `.pp` which will be used to configure our target systems
- The `template` directory works similar like "files directory" but will be used to generate any desired content on target nodes

```
ls -al
cd "new module name"
ls -al
```

#### We have to Create a Puppet Manifest Class Definition
- A Class Definition In Puppet Configures One/1 Unit of the Overall Installation or Module like (Install), (Start) and (Enable) Nginx
- **Run** Confirm you're in `/etc/puppetlabs/code/environments/production/modules/nginx`
```
pwd
```
- **Run** To Create The New class name `install`
- You need to be in the `nginx` root directory because, the `PDK` relies solely on the `metadata.json` config file for the class definition creation/generation
```
pdk new class install
```
- MAKE sure you have the following output and Confim you have the `install.pp` in the `Manifest Directory`
```
OUTPUT
---------------Files added--------------
/etc/puppetlabs/code/environments/production/modules/nginx/spec/classes/install_spec.rb
/etc/puppetlabs/code/environments/production/modules/nginx/manifests/install.pp
----------------------------------------
```

#### We're now going to Configure this to match our Configuration for `Nginx Installation`
```
cd manifests
vi install.pp
```
- Add The Following Peace of Code in your install.pp manifest
```bash
class nginx::install {
  package { 'install_nginx':
    name   => 'nginx',
    ensure => 'present',
  }
}
```

- Use the `Puppet Passer` to Validate the Manifest Configuration. Make sure there are no ERRORS
```bash
export PATH=/opt/puppetlabs/bin/:$PATH
puppet parser validate install.pp
```

- We Need to Now create our `init.pp` Class and `site.pp` Class
    - The `init.pp` Class is one class that every Module configuration needs to have. It's what Puppet Calls when we reference the module
    - If we need to reference our `init.pp` file all we do is call `nginx` itself which the `init.pp` class will help us to achieve
```bash
cd /etc/puppetlabs/code/environments/production/manifests/nginx
pdk new class nginx
puppet parser validate manifests/init.pp
```

- Pass in the following Code and SAVE and Quit
```bash
class nginx {
  contain nginx::install
}
```

- We're going going to Create a Puppet Master and Node/Client Integration using the `site.pp` config file
- This `site.pp` file, tells Puppet Master that we would like to Map the `Nginx` install manifest with the Webserver Node
- Drop Down to your `production/manifest` directory and create the `site.pp`
```
cd /etc/puppetlabs/code/environments/production/manifests/
vi /etc/puppetlabs/code/environments/production/manifests/site.pp
puppet parser validate site.pp
```

- Pass the Following Code in your `site.pp` file. Note the ``default`` represent your Prod Client Node.
```
node default {
  class { 'nginx': }
}
```

### Run a Catalog Converge From Puppet Client So It Can Pull Down The `Nginx` Installation Configuration
- We Can Either Wait For `30 Minute`, So Puppet Can Automatically Run Based On it Default Schedule or Force Run it From Client Nodes
- **NOTE:** We can also update this default run time to any frequency we want like `2 minute`, or `5 minutes` etc
1. Navigate to your `Puppet Client Node`
2. Run the following Command on your `Puppet Client Node`
```
/opt/puppetlabs/bin/puppet agent --test
```

3. Make sure you have the below RESULT Output
```bash
root@ip-172-31-27-122:/home/ubuntu# sudo /opt/puppetlabs/bin/puppet agent --test
Info: Using environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for ip-172-31-27-122.us-west-2.compute.internal
Info: Applying configuration version '1689006041'
Notice: /Stage[main]/Nginx::Install/Package[install_nginx]/ensure: created
Notice: Applied catalog in 12.88 seconds
```

4. Verify and Make Sure `Nginx Is Installed`. Make sure Nginx is `Active` and  `Running`
```
which nginx
systemctl status nginx
```








