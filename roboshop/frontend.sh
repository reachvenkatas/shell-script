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
systemctl start nginx &>>$LOG
statusCheck $?

PRINT "download static content - front end"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
statusCheck $?

PRINT "remove the old HTDOCS"
cd /usr/share/nginx/html &>>$LOG && rm -rf * &>>$LOG
statusCheck $?

PRINT "Etract HTDOCS files"
unzip /tmp/frontend.zip &>>$LOG && mv frontend-main/* . &>>$LOG && mv static/* . &>>$LOG && rm -rf frontend-master static &>>$LOG
statusCheck $?

PRINT "Moves the conf file to nginx location"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG
statusCheck $?

PRINT "ReStarting the  Nginx"
systemctl restart nginx &>>$LOG
statusCheck $?
