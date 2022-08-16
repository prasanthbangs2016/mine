#!/bin/bash
source components/common.sh
#removing log file for every time to have latest run log
rm -rf /tmp/roboshop.log


HEAD "Installing Nodejs"
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

HEAD "Unzip downloaded cart code"
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
cd /home/roboshop
rm -rf *
unzip -o /tmp/cart.zip &>>/tmp/roboshop.log
mv cart-main cart
cd cart
npm install --unsafe-perm &>>/tmp/roboshop.log
STAT $?


HEAD "Fix app permissions\t"
#as we ran using sudo it will have root and its requires roboshop
chown roboshop:roboshop /home/roboshop -R
STAT $?

HEAD "Update REDIS and Catalogue server in user"
#sudo su -
#cat /home/roboshop/catalogue/systemd.service
sed -i -e 's/REDIS_ENDPOINT/dev-redis.roboshop.ppk/' /home/roboshop/cart/systemd.service &>>/tmp/roboshop.log
sed -i -e 's/CATALOGUE_ENDPOINT/dev-catalogue.roboshop.ppk/' /home/roboshop/cart/systemd.service &>>/tmp/roboshop.log
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
STAT $?

HEAD "Starting systemD of cart component"
systemctl daemon-reload && systemctl enable cart &>>/tmp/roboshop.log && systemctl restart cart &>>/tmp/roboshop.log
STAT $?