#!/bin/bash

AMI=ami-03265a0778a880afb
SG_ID=sg-037a43886a4370096
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")



for i in "${INSTANCES[@]}"
do
        if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shipping" ]
        then
            INSTANCE_TYPE="t3.small"
        else
            INSTANCE_TYPE="t2.micro"
        fi
        aws ec2 run-instances --image-id $AMI --count 1 --instance-type t2.micro --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]"

done
