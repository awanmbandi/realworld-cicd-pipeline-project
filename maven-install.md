The following are instructions for installing Apache Maven and Java 8 on an Amazon EC2 instance. These are required for the Amazon Neptune Signature Version 4 authentication samples.

## Steps To Install Apache Maven and Java 8 on your EC2 instance

1. Connect to your Amazon EC2 instance with an SSH client.

2. Install Apache Maven on your EC2 instance. First, enter the following to add a repository with a Maven package.

    ```
    sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
    ```

- Enter the following to set the version number for the packages.

    ```
    sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
    ```
- Then you can use yum to install Maven.

    ```
    sudo yum install -y apache-maven
    ```
3. The Gremlin libraries require Java 8. Enter the following to install Java 8 on your EC2 instance.

    ```
    sudo yum install java-1.8.0-devel -y
    ```
4. Install Java11 for SonarQube
   ```
   sudo amazon-linux-extras install java-openjdk11
   ```
6. Enter the following to set Java 8 as the default runtime on your EC2 instance.

    ```
    sudo /usr/sbin/alternatives --config java
    ```
- When prompted, enter the number `4` for Java 11.

5. Enter the following to set Java 8 as the default compiler on your EC2 instance.

    ```
    sudo /usr/sbin/alternatives --config javac
    ```
- When prompted, enter the number `2` for Javac maven compiler.
- Make sure to review this config if `mvn compile` breaks

6. Verify your maven version
    ```
    mvn -v
    ```

### Install Git
```
sudo yum install git -y
```
### Project Preparation
7. Create the `.m2` directory in the home directory of your current user
    ```
    mkdir ~/.m2
    ```

8. Create the Settings file inside of the `~/.m2` directory
    ```
    cd ~/.m2/
    mv demo/settings.xml ~/.m2/
    ```
