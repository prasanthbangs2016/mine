#!/bin/bash
source components/common.sh
rm -rf /tmp/roboshop.log

HEAD "Installing Nodejs"
#yum install nodejs make gcc-c++ -y &>>/tmp/roboshop.log
curl –sL https://rpm.nodesource.com/setup_10.x | sudo bash - &>>/tmp/roboshop.log
sudo yum install nodejs make gcc-c++ -y &>>/tmp/roboshop.log
node --version
npm --version
STAT $?

<<comment
Let's now set up the catalogue application.

As part of operating system standards, we run all the applications and databases as a normal user but not with root user.

So to run the catalogue service we choose to run as a normal user and that user name should be more relevant to the project. Hence we will use roboshop as the username to run the service.
comment

HEAD "Add roboshop user"
#checking roboshop user id is exit or no
id roboshop &>>/tmp/roboshop.log
if [ $? -eq 0 ]; then
  echo "Roboshop user is already exist so skipping"  &>>/tmp/roboshop.log
  STAT $?
else
  useradd roboshop &>>/tmp/roboshop.log
  STAT $?
fi 


HEAD "Download code from github"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "Extract the downloaded code"
cd /home/roboshop && rm -rf catalogue && unzip -o /tmp/catalogue.zip &>>/tmp/roboshop.log && mv catalogue-main catalogue
STAT $?

HEAD "Install NPM module"
#--unsafe-perm : switching sudo is complex in shell scripting hence this
cd /home/roboshop/catalogue && npm install --unsafe-perm &>>/tmp/roboshop.log
STAT $?

HEAD "Fix app permissions"
#as we ran using sudo it will have root and its requires roboshop
chown roboshop:roboshop /home/roboshop -R
STAT $?

#update the IP address of MONGODB Server in systemd.service file

HEAD "Update mongodb server in catalogue"
#sudo su -
#cat /home/roboshop/catalogue/systemd.service
sed -i -e 's/MONGO_DNSNAME/dev-mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service &>>/tmp/roboshop.log
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
STAT $?

HEAD "Start catalogue service"
systemctl daemon-reload && systemctl enable catalogue &>>/tmp/roboshop.log && systemctl restart catalogue &>>/tmp/roboshop.log
STAT $?

