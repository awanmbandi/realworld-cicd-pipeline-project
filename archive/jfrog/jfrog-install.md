## Install JFrog Artifactory Manager
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