#!/bin/bash
source components/common.sh
#removing log file for every time to have latest run log
rm -rf /tmp/roboshop.log
set-hostname -skip-apply redis

HEAD "setup redis repo"
curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>/tmp/roboshop.log
yum install redis-6.2.7 -y &>>/tmp/roboshop.log
STAT $?

<<comment
Update the bind from 127.0.0.1 to 0.0.0.0 in config file /etc/redis.conf & /etc/redis/redis.conf
comment
HEAD "Update redis bind ip"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>>/tmp/roboshop.log
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf &>>/tmp/roboshop.log
STAT $?

HEAD "Start Redis"
systemctl enable redis &>>/tmp/roboshop.log && systemctl start redis &>>/tmp/roboshop.log
STAT $?