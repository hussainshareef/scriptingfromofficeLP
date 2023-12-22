#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H:%M:%S)
LOGFILE='/tmp/-$0-$TIMESTAMP.log'

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e " $2 ... $R FAILED $N"
        exit 1
    else
        echo -e " $2 ... $G SUCCESS $N" 
    fi
}

if [ $ID -ne 0]
then
    echo -e " $R ERROR: User is not a root one $N"  
    exit 1
else
    echo -e " $G User is a root one $N"
fi

dnf module disable nodejs -y 

VALIDATE $? "Disabling the nodejs"

dnf module enable nodejs:18 -y

VALIDATE $? "Enabling the nodejs:18"

dnf install nodejs -y

VALIDATE $? "Installing the nodejs:18"

id roboshop
if [ $? -ne 0 ]
then
    useradd roboshop
    VALIDATE $? "roboshop user is creating"
else
    echo -e "User was already added : $Y SKIPPING $N"

mkdir -p /app

VALIDATE $? "app directory created"

curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip

VALIDATE $? "Downloading the project in zip at /tmp/user directory"

cd /app

unzip -o /tmp/user.zip

VALIDATE $? "unzipping the roboshop project created"

npm install 

VALIDATE $? "Installing dependencies"

cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service

VALIDATE $? "coping catalogue service file"

systemctl daemon-reload

systemctl enable user 

systemctl start user

cp mongo.repo /etc/yum.repos.d/mongo.repo

dnf install mongodb-org-shell -y

mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js
