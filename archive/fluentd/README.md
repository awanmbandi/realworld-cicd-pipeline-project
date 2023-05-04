## Install and Configure Fluentd For Centralized Logging

![FluentdArch!](https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/zdocs/images/fluentd-arch.png) 

- OS: Amazon Linux 2
- Link: https://catalog.us-east-1.prod.workshops.aws/workshops/60a6ee4e-e32d-42f5-bd9b-4a2f7c135a72/en-US/05-ingest-and-process-application-logs/05-3-install-and-configure-fluentd

## For `httpd/access_log`
```
cat << EOF | sudo tee /etc/td-agent/td-agent.conf
<source>
  @type tail
  path /var/log/httpd/access_log
  <parse>
    @type none
  </parse>
  tag apache
</source>
<match apache>
  @type s3
  s3_bucket fluentd-logging-bucket-230067694882
  s3_region us-east-1
  path UserLogs/apache/httpd/access/
  time_slice_format %Y/%m/%d/%H/%M
  time_slice_wait 60
  <format>
    @type single_value
  </format>
  <buffer>
    timekey 60
    timekey_wait 60
  </buffer>
</match>
EOF
```

## For `syslog`
```
cat << EOF | sudo tee /etc/td-agent/td-agent.conf
<source>
  @type tail
  path /var/log/syslog
  <parse>
    @type none
  </parse>
  tag apache
</source>
<match apache>
  @type s3
  s3_bucket fluentd-logging-bucket-230067694882
  s3_region us-east-1
  path UserLogs/apache/httpd/access/
  time_slice_format %Y/%m/%d/%H/%M
  time_slice_wait 60
  <format>
    @type single_value
  </format>
  <buffer>
    timekey 60
    timekey_wait 60
  </buffer>
</match>
EOF
```

## For `boot.log`
```
cat << EOF | sudo tee /etc/td-agent/td-agent.conf
<source>
  @type tail
  path /var/log/.......
  <parse>
    @type none
  </parse>
  tag apache
</source>
<match apache>
  @type s3
  s3_bucket fluentd-logging-bucket-230067694882
  s3_region us-east-1
  path UserLogs/apache/httpd/access/
  time_slice_format %Y/%m/%d/%H/%M
  time_slice_wait 60
  <format>
    @type single_value
  </format>
  <buffer>
    timekey 60
    timekey_wait 60
  </buffer>
</match>
EOF
```