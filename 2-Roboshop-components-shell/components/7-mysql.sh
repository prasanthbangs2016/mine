#!/bin/bash
COMPONENT=mysql
source components/common.sh
rm -rf /tmp/roboshop.log

#if [ -z "$MYSQL_PASSWORD" ]; then
#  echo -e "\e[33m env variable MYSQL_PASSWORD is missing \e[0m"
#  exit 1
#fi

HEAD "Installing Mysql"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>/tmp/roboshop.log
yum install mysql-community-server -y &>>/tmp/roboshop.log
STAT $?

HEAD "start mysql service and reset password"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl start mysqld &>>/tmp/roboshop.log
STAT $?

#DEFAULT_PASSWORD=$(sudo grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')
#echo "show databases;" | mysql -uroot -p$MYSQL_PASSWORD &>>/tmp/roboshop.log
#if above commnand password is wrong we're changing the password
#if [ $? -ne 0 ]; then
DEFAULT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Roboshop@1'; 
uninstall plugin validate_password;" >/tmp/db.sql

#fi
echo "show databases;" | mysql -uroot -pRoboshop@1 &>>/tmp/roboshop.log
if [ $? -ne 0 ]; then
# if command is successful we are not changing the password
    HEAD "Reset mysql password"
    #--connect-expired-password :option is expected as default passwd expired for changing
    mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}" </tmp/db.sql &>>/tmp/roboshop.log #</tmp/db.sql &>>/tmp/roboshop.log
    STAT $?
fi

#HEAD "checking plugin is available or not if not available removing it"
#echo "show plugins;" | mysql -uroot -p$MYSQL_PASSWORD 2>&1 | grep validate_password &>>/tmp/roboshop.log
#checking plugin is available or not if not available removing it
#if [ $? -eq 0 ]; then
  #echo Remove Password Validate Plugin
  #echo "uninstall plugin validate_password;" | mysql -uroot -p$MYSQL_PASSWORD &>>/tmp/roboshop.log
  #STAT $?
#fi

#HEAD "Reset mysql password"
#mysql -uroot -p"${DEFAULT_PASSWORD}" &>>/tmp/roboshop.log
#STAT $?

HEAD "Downloading mysql files from repo"
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "load DB schemas"
cd /tmp && unzip -o mysql.zip &>>/tmp/roboshop.log && cd mysql-main && mysql -uroot -pRoboshop@1 <shipping.sql &>>/tmp/roboshop.log
STAT $?




