#!/bin/bash
source components/common.sh
rm -rf /tmp/roboshop.log

HEAD "Setup mongodb yum repo files"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
STAT $?

HEAD "Install mongodb"
yum install -y mongodb-org
STAT $?

HEAD "Start mongodb"
systemctl enable mongod &>>/tmp/rboshop.log
systemctl start mongod &>>/tmp/roboshop.log
STAT $?

#Update Liste IP address from 127.0.0.1 to 0.0.0.0 in config file
#Config file: /etc/mongod.conf
#then restart the service
# systemctl restart mongod

HEAD "Download mongodb from github"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
STAT $?

HEAD "Unzip mongodb files and Load schema files"
cd /tmp && unzip mongodb.zip &>>/tmp/rboshop.log && cd mongodb-main && mongo < catalogue.js &>>/tmp/rboshop.log mongo < users.js &>>/tmp/rboshop.log
STAT $?

