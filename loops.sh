#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=(date +%F-%H:%M:%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo " Script started execting at $TIMESTAMP " &>> $LOGFILE

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILED $N" &>> $LOGFILE
        exit 1
    else
        echo -e "$2 .... $G SUCCESS $N" &>> $LOGFILE
    fi
}

if [ $ID -ne 0 ]
then
    echo -e "$R ERROR $N : User is not a root" 
    exit 1
else
    echo -e "$G User is a root one" 
fi

for package in $@

do
    yum installed $package list &>> $LOGFILE
    if [ $? -ne 0]
    then
        yum install $package -y &>> $LOGFILE
        
        VALIDATE $? "Installation of $package"
    else
        echo "$package is already installed ...SKIPPING"
    fi
done
