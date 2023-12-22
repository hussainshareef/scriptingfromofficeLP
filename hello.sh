#!/bin/bash

ID=$(id -u)

#R="\e[31m"
#G="\e[32m"
#Y="\e[33m"
#N="\e[0m"

#TIMESTAMP=$(date +%F-%H:%M:%S)
#LOGFILE="/tmp/$0-$TIMESTAMP.log"

if [ $ID -ne 0 ]
then
    echo "ERROR: User is not a root"
    exit 1
else
    echo "User is a root one"
fi