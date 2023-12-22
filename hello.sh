#!/bin/bash

ID=$(id -u)

if [ $ID -ne 0 ]
then
    echo "ERROR: User is not a root"
    exit 1
else
    echo "User is a root one"
fi