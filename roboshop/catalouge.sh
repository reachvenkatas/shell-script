#!/bin/bash
source common.sh

PRINT "Installing nodejs"
yum install nodejs make gcc-c++ -y &>>$LOG
statusCheck $?

PRINT "Add Roboshop user"
# have to check the user already exist or not
id roboshop &>>$LOG
if [ $? -ne 0 ];  then
useradd roboshop &>>$LOG
fi
statusCheck $?

PRINT "Download downloaded code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG
statusCheck $?

PRINT "Extract downloaded code"
cd /home/roboshop && unzip -o /tmp/catalogue.zip &>>$LOG && rm -rf catalogue && mv catalogue-main catalogue
cd /home/roboshop/catalogue && npm install --unsafe-perm &>>$LOG
statusCheck $?

PRINT "Install nodeJS dependencies"
cd /home/roboshop/catalogue && npm install --unsafe-perm &>>$LOG
statusCheck $?

PRINT"Fix Application Permissions"
chown roboshop:roboshop /home/roboshop -R &>>$LOG
statusCheck $?


#PRINT "Extract downloaded code"

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue