#!/bin/bash
source components/common.sh
rm -rf /tmp/roboshop.log

HEAD "Installing Nodejs"
yum install nodejs make gcc-c++ -y &>>/tmp/roboshop.log
STAT $?

<<comment
Let's now set up the catalogue application.

As part of operating system standards, we run all the applications and databases as a normal user but not with root user.

So to run the catalogue service we choose to run as a normal user and that user name should be more relevant to the project. Hence we will use roboshop as the username to run the service.
comment

#HEAD "Add roboshop user"
#useradd roboshop
#STAT $?

HEAD "Download code from github"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "Extract the downloaded code"
cd /home/roboshop && unzip -o /tmp/catalogue.zip &>>/tmp/roboshop.log && mv catalogue-main catalogue
STAT $?

HEAD "Install NPM module"
cd /home/roboshop/catalogue && npm install &>>/tmp/roboshop.log
STAT $?
