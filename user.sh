#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H:%M:%S)
LOGFILE='/tmp/-$0-$TIMESTAMP.log'

MONGODB_HOST=mongodb.shareefdevops.online

echo " Script started from here at $TIMESTAMP."  &>> $LOGFILE

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e " $2 ... $R FAILED $N" &>> $LOGFILE
        exit 1
    else
        echo -e " $2 ... $G SUCCESS $N" &>> $LOGFILE
    fi
}

if [ $ID -ne 0]
then
    echo -e " $R ERROR: User is not a root one $N"  
    exit 1
else
    echo -e " $G User is a root one $N" &>> $LOGFILE
fi

dnf module disable nodejs -y &>> $LOGFILE

VALIDATE $? "Disabling the nodejs"

dnf module enable nodejs:18 -y &>> $LOGFILE

VALIDATE $? "Enabling the nodejs:18"

dnf install nodejs -y &>> $LOGFILE

VALIDATE $? "Installing the nodejs:18"

id roboshop
if [ $? -ne 0 ]
then
    useradd roboshop &>> $LOGFILE
    VALIDATE $? "roboshop user is creating"
else
    echo -e "User was already added : $Y SKIPPING $N"

mkdir -p /app &>> $LOGFILE

VALIDATE $? "app directory created"

curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>> $LOGFILE

VALIDATE $? "Downloading the project in zip at /tmp/user directory"

cd /app &>> $LOGFILE

unzip -o /tmp/user.zip &>> $LOGFILE

VALIDATE $? "unzipping the roboshop project created"

npm install &>> $LOGFILE

VALIDATE $? "Installing dependencies"

cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service &>> $LOGFILE

VALIDATE $? "copying catalogue service file"

systemctl daemon-reload &>> $LOGFILE

VALIDATE $? "daemon reload service file"

systemctl enable user &>> $LOGFILE

VALIDATE $? "enabling user"

systemctl start user &>> $LOGFILE

VALIDATE $? "starting user"

cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE

VALIDATE $? "coping mongo.repo to yum"

dnf install mongodb-org-shell -y &>> $LOGFILE

VALIDATE $? "Installing client side data"

mongo --host $MONGODB_HOST </app/schema/user.js &>> $LOGFILE

VALIDATE $? "Loading userdata into mongoDB"
