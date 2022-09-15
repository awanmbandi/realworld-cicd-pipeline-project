## Install Nexus Repository Manager
- https://github.com/awanmbandi/maven-nexus-project-eagles-batch/blob/maven-nexus-install/nexus-install.sh

## Install Apache Maven
- https://github.com/awanmbandi/maven-nexus-project-eagles-batch/blob/maven-nexus-install/maven-install.md

## Configure Nexus Repository
Series of tutorial code snippets for use
#Maven publish tutorial steps
Publishing artifact to Nexus snapshot and release repo using maven.

1. Create a snapshot repo using nexus, or use default coming in out of the box. DEFAULT 
2. Create a release repo using nexus, or use default coming out of the box. DEFAULT
3. Create a group repo having both release, snapshot and other third party repos. or use default coming out of the box.
4. Download spring initializer project
5. Go settings.xml under <MAVEN_INSTALL_LOCATION>\apache-maven-3.6.0\conf or C:\Users\<USER_NAME>\.m2  or mkdir ~/.m2
6. Create/Move profiles named snapshot and release in settings.xml in `~/.m2` (can be done in pom.xml as well)
7. Add server user name and pwd in setting.xml (Encrypted recommended).
8. Edit pom.xml and add repository and snapshot repository in distribution management tag DEFAULT/DONE
9. Mark id should match in step 7 with server id of settings.xml, UPDATE NEXUS IP
10. Run the following `maven`/`mvn` commands to validate/package/deploy your app artifacts remotely
   - `mvn validate`   (validate the project is correct and all necessary information is available.)
   - `mvn compile`    (compile the source code of the project)
   - `mvn test`       (run tests using a suitable unit testing framework. These tests should not require the code be packaged or deployed.)
   - `mvn package`    (take the compiled code and package it in its distributable format, such as a WAR/JAR/EAR.)
   - `mvn verify`     (run any checks to verify the package is valid and meets quality criteria.)
   - `mvn install`    (install the package into the local repository, for use as a dependency in other projects locally.)
   - `mvn deploy`     (done in an integration or release environment, copies the final package to the remote/SNAPSHOT repository 
                      for sharing with other developers and projects.)

11. Change the version from 1.0-Snapshot to 1.0
12. Run `mvn deploy` to deploy to Snapshot Repo or `mvn clean deploy -P release`, to deploy it to Release Repo

## Maven Lifecycle Phases
- https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html#a-build-lifecycle-is-made-up-of-phases

