#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)

echo -e "Script started executing at $Y $TIMESTAMP $N"

if [ $ID -ne 0 ]
then
    echo -e "$R ERROR: User is not a root $N"
    exit 1
else
    echo -e "$G User is a root one $N"
fi