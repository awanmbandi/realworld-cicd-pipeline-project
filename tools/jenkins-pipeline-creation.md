## 5️⃣ CREATE PROJECT PIPELINE JOBS

### 5.1. Create Maven Build, Test and Deploy Job
###### Maven Validate Job
- Click on `New Item`
    - Name: `Maven-CI-Pipeline-Project-Validate`
    - Type: `Freestyle`
    - Click: `OK`
        - Select: `GitHub project`, Project url: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Select `Restrict where this project can be run:`, Label Expression: `Maven-Build-Env`
    - Select `Git`, Repository URL: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Branches to build: `*/main` or `master`
    - Build Steps: `Execute Shell`
        - Command: `mvn validate`
    - `APPLY` and `SAVE`

###### Maven Unit Test Job
- Click on `New Item`
    - Name: `Maven-CI-Pipeline-Project-Unit-Test`
    - Type: `Freestyle`
    - Click: `OK`
        - Select: `GitHub project`, Project url: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Select `Restrict where this project can be run:`, Label Expression: `Maven-Build-Env`
    - Select `Git`, Repository URL: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Branches to build: `*/main` or `master`
    - Build Steps: `Execute Shell`
        - Command: `mvn test`
    - `APPLY` and `SAVE`

###### Maven Package/Build Job
- Click on `New Item`
    - Name: `Maven-CI-Pipeline-Project-Package`
    - Type: `Freestyle`
    - Click: `OK`
        - Select: `GitHub project`, Project url: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Select `Restrict where this project can be run:`, Label Expression: `Maven-Build-Env`
    - Select `Git`, Repository URL: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Branches to build: `*/main` or `master`
    - Build Steps: `Execute Shell`
        - Command: `mvn clean build`
    - `APPLY` and `SAVE`

###### Maven SonarQube Test Job
- Click on `New Item`
    - Name: `Maven-CI-Pipeline-Project-SonarQube-Test`
    - Type: `Freestyle`
    - Click: `OK`
        - Select: `GitHub project`, Project url: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Select `Restrict where this project can be run:`, Label Expression: `Maven-Build-Env`
    - Select `Git`, Repository URL: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Branches to build: `*/main` or `master`
    - Build Steps: `Execute Shell`
        - Command:
          """mvn sonar:sonar \
                -Dsonar.projectKey=Maven-JavaWebApp-Analysis \
                -Dsonar.host.url=http://PROVIDE_PRIVATE_IP:9000 \
                -Dsonar.login=SONARQUBE_PROJECT_AUTHORIZATION_TOKEN"""
    - `APPLY` and `SAVE`

###### Maven Nexus Upload Job
- Click on `New Item`
    - Name: `Maven-CI-Pipeline-Nexus-Upload`
    - Type: `Freestyle`
    - Click: `OK`
        - Select: `GitHub project`, Project url: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Select `Restrict where this project can be run:`, Label Expression: `Maven-Build-Env`
    - Select `Git`, Repository URL: `YOUR_MAVEN_PROJECT_REPOSITORY`
    - Branches to build: `*/main` or `master`
    - Build Steps: `Execute Shell`
        - Command: 
          `mvn deploy`
    
    - `APPLY` and `SAVE`

## 6️⃣ JOB INTEGRATION

### 6.1. Integrate The Maven JOBS Together To Create a CI Pipeline
1. Click on your `First Job` > Click `Configure` 
- Scroll to `Post-build Actions` Click `Add P-B-A` >> Projects to build "Select" `Second Job`
2. Click on your `Second Job` > Click `Configure` 
- Scroll to `Post-build Actions` Click `Add P-B-A` >> Projects to build "Select" `Third Job`

## 4️⃣ Plugin Installation Before Job Creation
- Install: `Delivery Pipeline` plugin
    - Click on `Dashboard` on Jenkins
    - Click on The `+` on your Jenkins Dashboard and Configure the View
    - Select ``Enable start of new pipeline build``
    - Pipelines >> Components >> Click `Add`
        - Name: `Maven-Continuous-Integration-Pipeline` or `Gradle-Continuous-Integration-Pipeline`
        - Initial Job: Select either the `Maven Build Job or 1st Job` or `Gradle Build Job or 1st Job`
    - APPLY and SAVE

## 7️⃣ TEST YOUR PIPELINE
