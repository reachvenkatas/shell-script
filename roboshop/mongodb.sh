#! /bin/bash
source common.sh
PRINT "adding the mongodb repo to yum repo"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
statusCheck $?

PRINT "Install MongoDB "
yum install -y mongodb-org &>>$LOG
statusCheck $?

PRINT "update mongodb listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
statusCheck $?

PRINT "enable  MongoDB"
systemctl enable mongod &>>$LOG
statusCheck $?

PRINT "Start  MongoDB"
systemctl start mongod &>>$LOG
statusCheck $?

PRINT "Download the MongoDB schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$LOG
statusCheck $?

PRINT "Load the Schema"
cd /tmp && unzip -o mongodb.zip &>>$LOG && cd mongodb-main && mongo < catalogue.js &>>$LOG && mongo < users.js &>>$LOG
statusCheck $?

