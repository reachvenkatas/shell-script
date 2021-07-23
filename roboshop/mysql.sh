#!/bin/bash

source common.sh

PRINT "Setup MySQL Repos\t"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
StatusCheck $?


PRINT "Install MySQL\t\t"
yum install mysql-community-server -y &>>$LOG
StatusCheck $?

PRINT "Start MySQL Service\t"
systemctl enable mysqld &>>$LOG  && systemctl start mysqld &>>$LOG
StatusCheck $?