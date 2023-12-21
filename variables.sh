#!/bin/bash

ID=$(id -u)
TIMESTAMP=(date +%F-%H:%M:%S)
LOGFILE="/bin/$0-$TIMESTAMP.log"



if [ $ID -ne 0 ]
then
    echo "ERROR: User is not a root"
    exit 1
else
    echo "User is a root one"
fi

yum install mysql -y

