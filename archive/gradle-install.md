## 1️⃣ Launch Gradle Environment and Configure
- Name: Gradle-Build-Env
- AMI: Ubuntu 20.04 LTS/HVM
- Instance type: t2.micro
- Security group ports: 22

## 2️⃣ SSH into your gradle vm and Configure Gradle
```bash
#!/bin/bash
sudo su
apt update -y
apt install openjdk-11-jdk -y
java -version
VERSION=6.8.3
wget https://services.gradle.org/distributions/gradle-${VERSION}-bin.zip -P /tmp
apt install unzip -y
unzip -d /opt/gradle /tmp/gradle-${VERSION}-bin.zip
ln -s /opt/gradle/gradle-${VERSION} /opt/gradle/latest
echo "export GRADLE_HOME=/opt/gradle/latest" >> /etc/profile.d/gradle.sh
echo "export PATH=${GRADLE_HOME}/bin:${PATH}" >> /etc/profile.d/gradle.sh
chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
gradle -v

## Provision Jenkins Master Access
useradd jenkinsmaster -m
echo "jenkinsmaster:jenkinsmaster" | chpasswd  ## Ubuntu

## Enable Password Authentication and Authorization
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "jenkinsmaster ALL=(ALL)" >> /etc/sudoers
chown -R jenkinsmaster:jenkinsmaster /opt

## Install git
apt install git -y
```

- NOTE/Test: ssh jenkinsmaster@GRADLE_VM_PUBLIC_IP

### 2.1. NOTE: (Only Neccessary if you're implementing this out locally) | Clone your Project repo
```bash
cd /home/ec2-user
git clone PROJECT_REPOSITORY_URL
cd PROJECT_REPO
```

## 3️⃣ Run a Test Build after configuring your Env and Pulling down the project Repo
```bash
gradle clean build
```

### 3.1. Confirm Build Artifact Once the Gradle Build is done
#### Artifact Name is "springboot-tomcat-gradle-war-0.0.1-SNAPSHOT.war"
```bash
cd /home/ec2-user/realworld-cicd-pipeline-project/build/libs
ls /home/ec2-user/realworld-cicd-pipeline-project/build/libs
```

## 4️⃣ Integrate Gradle with SonarQube
### 4.1. Update bellow property values for SonarQube Integration
1. Login to SonarQube and Create a Project called `Gradle-JavaWebApp`
```
vi build.gradle
```
- Look for the following piece of Code in the "build.gradle" config file
```bash
sonarqube {
    properties {
        property "sonar.sourceEncoding", "UTF-8"
                property "sonar.projectName", "springboot-tomcat-gradle-war"
                property "sonar.host.url", "http://65.1.95.116:9000"
                property "sonar.login", "6d7dcd10b8b2943128d0f7c5db306bf5aa723aa6"
    }
}
```

2. Execute SonarQube Code Analysis on generated artifact with the following command
```bash
gradle sonarqube
```

## 5️⃣ (OPTIONAL) (Not Needed If You Configured The Above Variables, PATH and SONAR Config)
- Assign execution "x" permission to your "gradlew" config file
```bash
chmod +x gradlew
```

- Then Run SonarQube Scan
```bash
./gradlew sonarqube \
  -Dsonar.projectKey=Gradle-JavaWebApp \
  -Dsonar.host.url=http://13.58.160.12:9000 \
  -Dsonar.login=658513ed6810d58fae16edb3f434833b109501a2
```

## 6️⃣ TROUBLESHOOTING
1. If you get an error about a certain "lock" when running SonarQube scan, please go ahead and run the following command to remove the lock and then Re-run the command that failed.
```bash
find ~/.gradle -type f -name "*.lock" -delete
```

2. If your Sonar scan still fails and this time it complains about "SonarQube analysis is already in progress" go ahead and run the following command and then Stop and Restart your Instance. 
```bash
rm -rf ~/.sonar
```
- Stop and Restart your Instance
- Then Re-run your SonarQube Scan and it should Succeed.

## 7️⃣ Integrate Nexus
1. Create a ``Maven2(hosted), Snapshot Repository`` in Nexus called `gradle-java-webapp-repository`
2. Edit the Nexus Block od Code in the "build.gradle" file. Update it with your "Nexus IP" and "Repository Name"
```bash
publishing {
    publications {
        maven(MavenPublication) {

            // bootJar is the default build task configured by Spring Boot
            artifact bootJar
        }
    }
    repositories {
        maven {
            url = "http://172.31.19.105:8081/repository/gradle-java-webapp-repository/"
            credentials {
                username "admin"
                password "admin"
            }
        }
    }
}
```

3. Confirm that you've already Build and Test with SonarQube. Now Publish to Nexus
```bash
gradle publish
```

4. Navigrate to Nexus >> Click on the BOX Icon >> Browse >> Click on the `gradle-java-webapp-repository` to Confirm that the Artifact was Published.

## Congratulations
