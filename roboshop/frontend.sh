#!/bin/bash
source common.sh

PRINT "Installing Nginx"
#Installing the NGinx and Redirecting the output to the log file
yum install nginx -y &>>$LOG
statusCheck $?

PRINT "Enabling the  Nginx"
systemctl enable nginx &>>$LOG
statusCheck $?

PRINT "Starting the  Nginx"
systemctll start nginx &>>$LOG
statusCheck $?
