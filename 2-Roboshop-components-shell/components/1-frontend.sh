#!/bin/bash
source components/common.sh
#removing log file for every time to have latest run log
rm -rf /tmp/roboshop.log
set-hostname frontend

HEAD "Installing Nginx\t"
#echo -n "Installing NGINX   ..."
yum install nginx -y &>>/tmp/roboshop.log
#failure checking

#yum install nginxx -y &>>/tmp/roboshop.log
#Prints msg in date format
#echo -e "[\e[1;34mINFO\e[0m] [\e[1;35m${COMPONENT}\e[0m] [\e[1;36m$(date '+%F %T')\e[0m] $1"
#checking exit status of previously executed command using function
STAT $?


HEAD "Download frontend from github"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "Delete old Nginx HTML Doc"
rm -rf /usr/share/nginx/html
STAT $?

HEAD "Unzip frontend code content"
#unzipping the files from /tmp/frontend.zip to /usr/share/nginx/html 
unzip -d /usr/share/nginx/html /tmp/frontend.zip &>>/tmp/roboshop.log
mv /usr/share/nginx/html/frontend-main/* /usr/share/nginx/html/. &>>/tmp/roboshop.log
mv /usr/share/nginx/html/static/* /usr/share/nginx/html/. &>>/tmp/roboshop.log
STAT $?

HEAD "Update Nginx configuration"
mv /usr/share/nginx/html/localhost.conf /etc/nginx/default.d/roboshop.conf
STAT $?

HEAD "update endpoints in nginx conf"
for comp in frontend mongodb catalogue redis user mysql shipping rabbitmq payment ; do
#search for loop comp varaible and search for localhost and replace it with loop variable comp
  sed -i -e "/${comp}/ s/localhost/${comp}.roboshop.ppk" /etc/nginx/default.d/roboshop.conf
done
STAT $?

#HEAD "Start nginx"
HEAD "Start nginx\t\t"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx  &>>/tmp/roboshop.log
STAT $?






