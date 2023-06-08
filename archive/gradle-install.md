## SSH into your gradle vm
```
sudo yum install java-1.8.0-devel -y
cd /opt
sudo wget https://distfiles.macports.org/gradle/gradle-6.8.3-bin.zip
sudo unzip gradle-6.8.3-bin.zip
export PATH=$PATH:/opt/gradle-6.8.3/bin
```

## Install Git and Clone your Project repo
```
sudo yum install git -y
git clone PROJECT_REPOSITORY_URL
cd PROJECT_REPO
```

## Run a Test Build after configuring your Env and Pulling down the project Repo
```
gradle clean build
```

## Confirm Build Artifact Once the Gradle Build is done
## Artifact Name is "springboot-tomcat-gradle-war-0.0.1-SNAPSHOT.war"
```
cd /home/ec2-user/realworld-cicd-pipeline-project/build/libs
ls /home/ec2-user/realworld-cicd-pipeline-project/build/libs
```

## 2.0 Integrate Gradle with SonarQube
### Update bellow property values for SonarQube integration
1. Login to SonarQube and Create a Project called `Gradle-JavaWebApp`
```
vi build.gradle
```
- Look for the following piece of Code in the "build.gradle" config file
```
sonarqube {
    properties {
        property "sonar.sourceEncoding", "UTF-8"
                property "sonar.projectName", "springboot-tomcat-gradle-war"
                property "sonar.host.url", "http://65.1.95.116:9000"
                property "sonar.login", "6d7dcd10b8b2943128d0f7c5db306bf5aa723aa6"
    }
}
```

2. Assign execution "x" permission to your "gradlew" config file
```
chmod +x gradlew
```

3. Execute SonarQube Code Analysis on generated artifact with the following command
```
gradle sonarqube
```

## 3. TROUBLESHOOTING
1. If you get an error about a certain "lock" when running SonarQube scan, please go ahead and run the following command to remove the lock and then Re-run the command that failed.
```
find ~/.gradle -type f -name "*.lock" -delete
```

2. If your Sonar scan still fails and this time it complains about "SonarQube analysis is already in progress" go ahead and run the following command and then Stop and Restart your Instance. 
```
rm -rf ~/.sonar
```
- Stop and Restart your Instance
- Then Re-run your SonarQube Scan and it should Succeed.