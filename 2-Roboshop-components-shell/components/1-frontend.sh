#!/bin/bash
source components/common.sh

HEAD "Installing Nginx"
#echo -n "Installing NGINX   ..."
yum install nginxs -y &>>/tmp/roboshop.log
#Prints msg in date format
#echo -e "[\e[1;34mINFO\e[0m] [\e[1;35m${COMPONENT}\e[0m] [\e[1;36m$(date '+%F %T')\e[0m] $1"
STAT $?


