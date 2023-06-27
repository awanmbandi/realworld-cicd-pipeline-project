## Install JFrog Artifactory Manager
### CentOs 7 Image
wget https://releases.jfrog.io/artifactory/artifactory-rpms/artifactory-rpms.repo -O jfrog-artifactory-rpms.repo;
sudo mv jfrog-artifactory-rpms.repo /etc/yum.repos.d/;
sudo yum update
sudo yum install jfrog-artifactory-oss
sudo systemctl enable artifactory.service
sudo systemctl start artifactory.service
sudo systemctl status artifactory.service

### Access JFrog Repository Manager
1. Copy the External/Public IP and past on the browser with column 8081 or 8082

2. Default Username and Password
- Username: `admin`
- Password: `password`

3. Change the your password to for example
- Make sure you're compliant based on the JFrog RM Default Password Policy
- New Password: `Admin@12345`




### Install on Debian
# To determine your distribution, run lsb_release -c or cat /etc/os-release
# Example:echo "deb https://releases.jfrog.io/artifactory/artifactory-pro-debs xenial main" | sudo tee -a /etc/apt/sources.list;
wget -qO - https://releases.jfrog.io/artifactory/api/gpg/key/public | sudo apt-key add -;
echo "deb https://releases.jfrog.io/artifactory/artifactory-debs {distribution} main" | sudo tee -a /etc/apt/sources.list;
sudo apt-get update && sudo apt-get install jfrog-artifactory-oss


## Downloading Artifacts from JFrog Using REAT API:GET
## THIS ONE <<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>
curl -u admin:Admin@12345 -XGET "http://34.68.141.102:8082/artifactory/gradle-javawebapp-local-repo/gradle-war/1.1/gradle-war-1.1.war" --output gradle-war-1.1.war -T ~/Downloads/jfrog

## Downloading Artifacts from JFrog Using REAT API:GET With Encrypted Password
curl -u admin:"sacavcdavasdvsdfvfsvs" -XGET "http://34.68.141.102:8082/artifactory/gradle-javawebapp-local-repo/gradle-war/1.1/gradle-war-1.1.war" --output gradle-war-1.1.war -T ~/Downloads/jfrog




























## JFrog Artifactory CLI Install and Configuration
set ARTIFACTORY_URL=http://34.68.141.102:8082/artifactory/
set ARTIFACTORY_USER=admin
set ARTIFACTORY_PASSWORD=Admin@12345
jfrog config add artifactory-server --artifactory-url="$ARTIFACTORY_URL" --user="$ARTIFACTORY_USER" --password="$ARTIFACTORY_PASSWORD" --interactive=false

### Setup Manually
jfrog config add
jfrog config show
jfrog config use jfrogartifactory2


wget -qO - https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog_public_gpg.key | sudo apt-key add -
echo "deb https://releases.jfrog.io/artifactory/jfrog-debs xenial contrib" | sudo tee -a /etc/apt/sources.list &&    sudo apt update &&
sudo apt install -y jfrog-cli-v2-jf &&
jf intro