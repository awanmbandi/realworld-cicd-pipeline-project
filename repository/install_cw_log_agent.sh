#!/bin/bash
sudo yum update -y
sudo yum install awslogs -y
sudo vi /etc/awslogs/awslogs.conf





[/var/log/tomcat/localhost_access_log.2023-10-09.txt]
datetime_format = %b %d %H:%M:%S
file = /var/log/tomcat/localhost_access_log.2023-10-09.txt
buffer_duration = 5000
log_stream_name = application-logs{instance_id}
initial_position = start_of_file
log_group_name = /var/log/tomcat/