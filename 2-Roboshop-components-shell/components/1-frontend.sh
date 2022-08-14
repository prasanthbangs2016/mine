#!/bin/bash
source components/common.sh
#removing log file for every time to have latest run log
rm -rf /tmp/roboshop.log

HEAD "Installing Nginx"
#echo -n "Installing NGINX   ..."
yum install nginx -y &>>/tmp/roboshop.log
#failure checking
#yum install nginxx -y &>>/tmp/roboshop.log
#Prints msg in date format
#echo -e "[\e[1;34mINFO\e[0m] [\e[1;35m${COMPONENT}\e[0m] [\e[1;36m$(date '+%F %T')\e[0m] $1"
#checking exit status of previously executed command using function
STAT $?

#HEAD "Start nginx"
HEAD "Start nginx\t"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl start nginx  &>>/tmp/roboshop.log
STAT $?




