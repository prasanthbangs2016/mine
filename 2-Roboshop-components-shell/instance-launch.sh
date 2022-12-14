#!/bin/bash
COMPONENT=$1

#validating command line argument variable is provided or not
#if it is empty then its true
if [ -z "${COMPONENT}" ]; then
  echo "Component name is needed"
  #if there is no cmd argument variable provided,not point continuing hence exit
  exit 1
fi

#$ bash instance-launch.sh
#o/p: Component name is needed


LaunchTemplateId=lt-0b86176ba30da7a45
Version=1

echo -e "\e[32m\t\tValidating ${COMPONENT} instance is already there\e[0m"
#filter the instance by tag
#also i want to tell whether instance is running/terminated/stopped as well
#Reservations[] : telling its a list
#Instances[] : telling its a list
#xargs -n1 : remove that quote ("terminated") : o/p: terminated

#aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].State.Name



DNS_UPDATE() {
#find ip address to add record in rout53
PRIVATEIP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].PrivateIpAddress | xargs -n1)
sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${PRIVATEIP}/" record.json >/tmp/record.json
aws route53 change-resource-record-sets --hosted-zone-id Z06386013LGCB19ECT5 --change-batch file:///tmp/record.json | jq
#validation
#add route53 full permission to aws cli user in iam
}

<<comment
INSTANCE_STATE=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].State.Name | xargs -n1)

if [ "${INSTANCE_STATE}" = "runnung" ]; then
  echo -e "\e[33m${COMPONENT} instance is already exist\e[0m"
  #as instance running exit
  exit 0
fi

if [ "${INSTANCE_STATE}" = "stopped" ]; then
  echo -e "\t\e[32m${COMPONENT} instance is already exist and stopped..! start the instance\e[0m"
  #as instance stopped exit
  exit 0
fi



#launch ec2 using launch template and specify tags to instance
#aws ec2 run-instances --launch-template LaunchTemplateId=lt-0b86176ba30da7a45,Version=1 --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=frontend}]'

#since with single quotes we cannot access the variable hence double quotes
#as output coming json format,whole output we're giving to "JQ" and that stops and takes us to cmdline
echo -e "\e[31m\t\tOh,No ${COMPONENT} instance is not there creating the instance ${COMPONENT}\e[0m"
aws ec2 run-instances --launch-template LaunchTemplateId=${LaunchTemplateId},Version=${Version} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq
#intentionally waiting as instance to be provisioned
sleep 30
DNS_UPDATE
comment

INSTANCE_CREATE() {
  INSTANCE_STATE=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].State.Name | xargs -n1)

if [ "${INSTANCE_STATE}" = "runnung" ]; then
  echo -e "\e[33m${COMPONENT} instance is already exist\e[0m"
  #as instance running exit
  exit 0
fi

if [ "${INSTANCE_STATE}" = "stopped" ]; then
  echo -e "\t\e[32m${COMPONENT} instance is already exist and stopped..! start the instance\e[0m"
  #as instance stopped exit
  exit 0
fi



#launch ec2 using launch template and specify tags to instance
#aws ec2 run-instances --launch-template LaunchTemplateId=lt-0b86176ba30da7a45,Version=1 --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=frontend}]'

#since with single quotes we cannot access the variable hence double quotes
#as output coming json format,whole output we're giving to "JQ" and that stops and takes us to cmdline
echo -e "\e[31m\t\tOh,No ${COMPONENT} instance is not there creating the instance ${COMPONENT}\e[0m"
aws ec2 run-instances --launch-template LaunchTemplateId=${LaunchTemplateId},Version=${Version} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq
#intentionally waiting as instance to be provisioned
sleep 30
DNS_UPDATE
}

if [ "${COMPONENT}" == "all" ]; then
  for Component in fronten mongodb catalogue redis user mysql shipping rabbitmq payment ; do
  COMPONENT=$Component
  INSTANCE_CREATE
  done
else 
  #if it is not all,it will create component we asked to run and provided as argument
  COMPONENT=$1
  INSTANCE_CREATE
fi



