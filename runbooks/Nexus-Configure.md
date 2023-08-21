## Configure Nexus
### Login to Nexus
  - CREATE MAVEN PROJECT ARTIFACT REPOSITORY
  - Click on the Admin Repository Secition
    - Click on `Repositories`
    - Click on `Create Repository`
      - Select: `Maven2(hosted)`
      - Name: `maven-java-webapp-repository`
      - Click: `CREATE`

  - CREATE GRADLE PROJECT ARTIFACT REPOSITORY
  - Click on the Admin Repository Secition
    - Click on `Repositories`
    - Click on `Create Repository`
      - Select: `Maven2(hosted)`
      - Name: `gradle-java-webapp-repository`
      - Click: `CREATE`

### 2) Update Maven (POM.xml, Settings.xml) And Gradle (build.gradle) File
  - Update The Nexus IP Addresses to Yours
  - Update The Nexus Repository to Yours "if different"

### 3) Add SonarQube Configurations In Maven Settings.xml and Gradle build.gradle File

### 4) Update The Maven Project Jenkins File With The SonarQube Generated Scanner Snippet
