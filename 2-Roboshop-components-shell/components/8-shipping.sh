#!/bin/bash
COMPONENT=mysql
source components/common.sh
rm -rf /tmp/roboshop.log


HEAD "Installing Maven"
yum install maven -y &>>/tmp/roboshop.log
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

HEAD "download shipping code from github"
curl -s -L -o /tmp/shipping.zip "https://github.com/roboshop-devops-project/shipping/archive/main.zip" &>>/tmp/roboshop.log
STAT $?


HEAD "unzip the code"
cd /home/roboshop
unzip -o /tmp/shipping.zip &>>/tmp/roboshop.log
STAT $?

HEAD "Fix app permissions\t"
#as we ran using sudo it will have root and its requires roboshop
chown roboshop:roboshop /home/roboshop -R
STAT $?


HEAD "Maven package for shipping"
mv shipping-main shipping
cd shipping
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar
STAT $?

HEAD "Update CARTENDPOINT and MYSQL ENDPOINT"
sed -i -e 's/CARTENDPOINT/6-dev-cart.roboshop.ppk/' /home/roboshop/shipping/systemd.service &>>/tmp/roboshop.log
sed -i -e 's/DBHOST/7-dev-mysql.roboshop.ppk/' /home/roboshop/shipping/systemd.service &>>/tmp/roboshop.log
mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service
STAT $?

HEAD "Start shipping Systemd"
systemctl daemon-reload && systemctl enable shipping &>>/tmp/roboshop.log && systemctl start shipping &>>/tmp/roboshop.log
