#!/bin/bash
source common.sh

PRINT "Installing nodejs"
yum install nodejs make gcc-c++ -y &>>$LOG
statusCheck $?

PRINT "Add Roboshop user"
useradd roboshop &>>$LOG
statusCheck $?

So let's switch to the roboshop user and run the following commands.

$ curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
$ cd /home/roboshop
$ unzip /tmp/catalogue.zip
$ mv catalogue-main catalogue
$ cd /home/roboshop/catalogue
$ npm install