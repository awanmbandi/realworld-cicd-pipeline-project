# Apache Maven Installation/Config
sudo su
yum update -y
sudo amazon-linux-extras install java-openjdk11 -y  # Use for Java and Maven Compiler
sudo /usr/sbin/alternatives --config java  # NOTE: Select 4 or 2 or 3 for java11
java --version
wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
yum install -y apache-maven

## Configure MAVEN_HOME and PATH Environment Variables
rm .bash_profile
wget https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/jenkins-master-client-config/.bash_profile
source .bash_profile
mvn -v

# Create ".m2" and download your "settings.xml" file into it to Authorize Maven
## Make sure to Update the RAW GITHUB Link to your "settings.xml" config
mkdir /var/lib/jenkins/.m2
wget https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/refs/heads/jenkins-maven-sonarqube-nexus/settings.xml -P /var/lib/jenkins/.m2/
chown -R jenkins:jenkins /var/lib/jenkins/.m2/
chown -R jenkins:jenkins /var/lib/jenkins/.m2/settings.xml

