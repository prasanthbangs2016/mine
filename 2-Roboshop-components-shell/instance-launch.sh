#!/bin/bash
COMPONENT=$1

#validating command line argument variable is provided or not
#if it is empty then its true
if [ -z "${COMPONENT}" ]; then
  echo "Component name is needed"
  #if there is no cmd argument variable provided,not point continuing hence exit
  exit 1
fi

LaunchTemplateId=lt-0b86176ba30da7a45
Version=1

#launch ec2 using launch template and specify tags to instance
#aws ec2 run-instances --launch-template LaunchTemplateId=lt-0b86176ba30da7a45,Version=1 --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=frontend}]'

#since with single quotes we cannot access the variable hence double quotes
aws ec2 run-instances --launch-template LaunchTemplateId=${LaunchTemplateId},Version=${Version} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"