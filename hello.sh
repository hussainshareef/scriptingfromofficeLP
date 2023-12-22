#!/bin/bash

ID=$(id -u)

if [ $ID -ne 0 ]
then
    echo "$R ERROR $N : User is not a root" &>> $LOGFILE
    exit 1
else
    echo "$G User is a root one" &>> $LOGFILE
fi