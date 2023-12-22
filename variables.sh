#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H:%M:%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo " Script started execting at $TIMESTAMP " &>> $LOGFILE

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 ... $R FAILED $N" &>> $LOGFILE
        exit 1
    else
        echo "$2 .... $G SUCCESS $N" &>> $LOGFILE
    fi
}

if [ $ID -ne 0 ]
then
    echo "$R ERROR $N : User is not a root" &>> $LOGFILE
    exit 1
else
    echo "$G User is a root one" &>> $LOGFILE
fi

yum install mysql -y

VALIDATE $? "$G Installing Mysql $N" &>> $LOGFILE

yum install git -y

VALIDATE $? "$G nstalling git $N" &>> $LOGFILE

# if we have mutiple packages need to install then
# it is difficult to execute each and every one. So,
# We will use loops 