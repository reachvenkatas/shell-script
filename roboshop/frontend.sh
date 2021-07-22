#!/bin/bash
LOG=/tmp/frontend.log
#mv $LOG /tmp/backup/$LOG_$(date +%F-%T).log
rm -f $LOG

echo -n -e "Installing Nginx\t\t\t..."
#Installing the NGinx and Redirecting the output to the log file
yum install nginx -y &>>$LOG
if  [ $? -eq 0 ]; then
  echo -e "\e[32mdone\e[0m"
else
  echo -e "\e[31mfail\e[0m"
  exit 1
fi

#step 1:outputs from the commands should not display on the screen
#step 2: validate the command executed fine or not($?)
#STep 3: Need to check the script is running as root user id or not

echo -e "Enabling the  Nginx\t\t\t..."
systemctl enable nginx &>>$LOG
if  [ $? -eq 0 ]; then
  echo -e "\e[32mdone\e[0m"
else
  echo -e "\e[31mfail\e[0m"
  exit 1
fi

echo -e "Starting the  Nginx\t\t\t..."
systemctl start nginx &>>$LOG
if  [ $? -eq 0]; then
  echo -e "\e[32mdone\e[0m"
else
  echo -e "\e[31mfail\e[0m"
  exit 1
fi
