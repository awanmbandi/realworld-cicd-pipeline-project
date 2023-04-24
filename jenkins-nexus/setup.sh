sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
#mvn -emp admin
sudo su
cd /root
mkdir .m2
cd .m2

cat <<EOT>> /root/.m2/settings-security.xml
<?xml version="1.0"?>
<settingsSecurity>
   <master>admin</master>
</settingsSecurity>
EOT

#mvn -ep admin
cat <<EOT>> /root/.m2/settings.xml
<?xml version="1.0" encoding="UTF-8"?>

<settings xmlns="http://maven.apache.org/POM/4.0.0"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

  <localRepository>/var/lib/jenkins/.m2/repository</localRepository>

<servers>
   <server>
        <id>nexus</id>
        <username>admin</username>
        <password>admin</password>
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
EOT

mv settings.xml /var/lib/jenkins/.m2
mv settings-security.xml /var/lib/jenkins/.m2
cd /var/lib/jenkins/.m2
chown jenkins:jenkins settings.xml settings-security.xml
chmod 755 settings.xml settings-security.xml