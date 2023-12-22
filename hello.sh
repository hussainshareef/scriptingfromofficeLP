#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H:%M:%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

if [ $ID -ne 0 ]
then
    echo "$R ERROR $N : User is not a root" &>> $LOGFILE
    exit 1
else
    echo "$G User is a root one" &>> $LOGFILE
fi