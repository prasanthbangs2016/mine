#!/bin/bash
COMPONENT=mysql
source components/common.sh
rm -rf /tmp/roboshop.log



HEAD "Download Erlang"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y &>>/tmp/roboshop.log
STAT $?

HEAD "Set up rabbitmq yum repo "
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>/tmp/roboshop.log
STAT $?

HEAD "Install rabbitmq"
yum install rabbitmq-server -y &>>/tmp/roboshop.log
STAT $?

HEAD "Start Rabbimq server"
systemctl enable rabbitmq-server &>>/tmp/roboshop.log && systemctl start rabbitmq-server &>>/tmp/roboshop.log
STAT $?

HEAD "create application rabbitmq new user and password and update "
<<comment
RabbitMQ comes with a default username / password as guest/guest. 
But this user cannot be used to connect. Hence we need to create one user for the application.
comment

rabbitmqctl add_user roboshop roboshop123 &>>/tmp/roboshop.log && rabbitmqctl set_user_tags roboshop administrator &>>/tmp/roboshop.log && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log
STAT $?





