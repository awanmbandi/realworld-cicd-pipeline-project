### Configure Nexus With Jenkins
A.  Install Maven (If Not Already Installed)
    
    ```
    sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
    
    sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
    
    sudo yum install -y apache-maven
    ```

-  We have to encrypt nexus password and update it in the file below
    ```
    mvn -emp admin
    ```
-  We have to encrypt nexus password and update it in the file below
    ```
    mvn -emp admin
    ```
-  Create folder in the root folder
  ```
   sudo su
   cd /root
   mkdir .m2
  
  ```
-  You will get an encrypted password from the above command, you need to change it in the below file.
  ```
  cd .m2
  ```
-  create settings-security.xml file and 
  ```
  vi settings-security.xml
  ```
-  Add the content to above file after change above password from line 6
  ```
  <?xml version="1.0"?>
  <settingsSecurity>
    <master>{admin}</master>
  </settingsSecurity>
  ```
-  We have to encrypt nexus password and update it in 9
  ```
  mvn -ep admin
  ```
-  create settings.xml file 
  ```
  vi settings.xml
  ```
-  Copy the below content after change the password from line 6. Also Update the Nexus IP Address on line 21 with your Nexus Private IP

  ```
<?xml version="1.0" encoding="UTF-8"?>

<settings xmlns="http://maven.apache.org/POM/4.0.0"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

  <localRepository>/var/lib/jenkins/.m2/repository</localRepository>

<servers>
  <server>
        <id>nexus</id>
        <username>admin</username>
        <password>{admin}</password>
    </server>
</servers>

<mirrors>
    <mirror>
      <id>nexus</id>
      <name>nexus</name>
      <url>http://13.235.132.119:8081/repository/maven_project/</url>
      <mirrorOf>*</mirrorOf>
    </mirror>
  </mirrors>

</settings>
  ```
-  move above two files to /var/lib/jenkins/.m2
  ```
  mv settings.xml /var/lib/jenkins/.m2
  mv settings-security.xml /var/lib/jenkins/.m2
  ```
-  To check
  ```
  ls /var/lib/jenkins/.m2
  ```
-  Get into the folder 
  ```
  cd /var/lib/jenkins/.m2
  ```
-  Change ownership of the 2 files
  ```
  chown jenkins:jenkins settings.xml settings-security.xml
  ```
-  Change permissions of the 2 files
  ```
  chmod 755 settings.xml settings-security.xml
  ```