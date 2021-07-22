#!/bin/bash
LOG=/tmp/frontend.log

echo -e "Installing Nginx\t\t...\t\e[32mdone\e[0m"
#Installing the NGinx and Redirecting the output to the log file
yum install nginx -y >>$LOG

echo -e "Enabling the  Nginx\t\t...\t\e[32mdone\e[0m"
systemctl enable nginx >>$LOG

echo -e "Starting the  Nginx\t\t...\t\e[32mdone\e[0m"
systemctl start nginx >>$LOG
