## JFrog Execution Command
mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false

## Add Distribution in POM.xml
<distributionManagement>
    <snapshotRepository>
        <id>snapshots</id>
        <name>a0dhlrpeubvqs-artifactory-primary-0-snapshots</name>
        <url>https://jjtechadmin.jfrog.io/artifactory/libs-snapshot</url>
    </snapshotRepository>
</distributionManagement>

## 