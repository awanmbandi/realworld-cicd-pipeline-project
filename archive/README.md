## Copy Artifact from Jenkins/Gradle Server to Puppet Master Configuration Class Environments Using SCP

```
sshpass -p "ROOT_USER_PASSWORD" scp ARTIFACT.war ROOT_USER_NAME@TARGET_HOST_IP:/destination/path/
```
```
sshpass -p "puppetdeployer" scp semanage.conf puppetdeployer@35.91.18.85:/home/puppetdeployer/
```