#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

if [ $ID -ne 0 ]
then
    echo "$R ERROR: User is not a root"
    exit 1
else
    echo "$G User is a root one"
fi