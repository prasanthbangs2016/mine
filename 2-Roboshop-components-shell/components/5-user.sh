#!/bin/bash
source components/common.sh
#removing log file for every time to have latest run log
rm -rf /tmp/roboshop.log
set-hostname -skip-apply user

HEAD "Installing node"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/rboshop.log
yum install nodejs -y &>>/tmp/rboshop.log

STAT $?

HEAD "Add roboshop user"
#checking roboshop user id is exist or no
id roboshop &>>/tmp/roboshop.log
if [ $? -eq 0 ]; then
  echo "Roboshop user is already exist so skipping"  &>>/tmp/roboshop.log
  STAT $?
else
  useradd roboshop &>>/tmp/roboshop.log
  STAT $?
fi 

HEAD "Download user code from github"
curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "Unzip downloaded user code"
cd /home/roboshop
rm -rf *
unzip -o /tmp/user.zip &>>/tmp/roboshop.log
mv user-main user
cd /home/roboshop/user
npm install --unsafe-perm &>>/tmp/roboshop.log
STAT $?

HEAD "Fix app permissions\t"
#as we ran using sudo it will have root and its requires roboshop
chown roboshop:roboshop /home/roboshop -R
STAT $?

HEAD "Update mongodb server in user"
#sudo su -
#cat /home/roboshop/catalogue/systemd.service
sed -i -e 's/MONGO_DNSNAME/dev-mongodb.roboshop.ppk/' /home/roboshop/user/systemd.service &>>/tmp/roboshop.log
sed -i -e 's/MONGO_ENDPOINT/dev-redis.roboshop.ppk/' /home/roboshop/user/systemd.service &>>/tmp/roboshop.log
mv /home/roboshop/user/systemd.service /etc/systemd/system/catalogue.service
STAT $?

HEAD "Starting systemD of user component"
systemctl daemon-reload &>>/tmp/roboshop.log && systemctl restart user &>>/tmp/roboshop.log
systemctl enable user
STAT $?
