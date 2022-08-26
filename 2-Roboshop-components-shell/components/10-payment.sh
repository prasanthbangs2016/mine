#!/bin/bash
source components/common.sh
rm -rf /tmp/roboshop.log

HEAD "Install python packages"
yum install python36 gcc python3-devel -y &>>/tmp/rboshop.log
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

HEAD "Downlad payment code from repo"
curl -L -s -o /tmp/payment.zip "https://github.com/roboshop-devops-project/payment/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "unzip the payment code"
cd /home/roboshop && unzip -o /tmp/payment.zip &>>/tmp/roboshop.log && mv payment-main payment
STAT $?

HEAD "Install python Dependencies"
cd /home/roboshop/payment 
pip3 install -r requirements.txt &>>/tmp/roboshop.log
STAT $?

USER_ID=${id -u roboshop}
GROUP_ID=${id -g roboshop}

HEAD "Update roboshop user and group in payment.init file"
<<comment
# cd /home/roboshop/payment 
# pip3 install -r requirements.txt

**Note: Above command may fail with permission denied, So run as root user**

1. Update the roboshop user and group id in `payment.ini` file.
comment

sed -i -e "/uid/ c uid=${USER_ID}" -e "/gid/ c gid={GROUP_ID}" /home/roboshop/payment/payment.ini  &>>/tmp/roboshop.log
STAT $?

HEAD "Update SystemD service for CART-USER-AMP:Host "
sed -i -e 's/CARTHOST/6-dev-cart.roboshop.ppk/' /home/roboshop/payment/systemd.service &>>/tmp/roboshop.log
sed -i -e 's/USERHOST/5-dev-user.roboshop.ppk/' /home/roboshop/payment/systemd.service &>>/tmp/roboshop.log
sed -i -e 's/AMQPHOST/9-dev-rabbitmq.roboshop.ppk/' /home/roboshop/payment/systemd.service &>>/tmp/roboshop.log
mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service
STAT $?

HEAD "Start Payment systemd"
systemctl daemon-reload && systemctl enable payment &>>/tmp/roboshop.log && systemctl start payment &>>/tmp/roboshop.log
STAT $?
