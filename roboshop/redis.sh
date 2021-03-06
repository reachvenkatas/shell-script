#! /bin/bash
source common.sh

PRINT "Install redis repo"
yum install epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$LOG
statusCheck $?

PRINT "Install redis"
yum install redis -y --enablerepo=remi &>>$LOG
statusCheck $?

PRINT "update redis Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf
statusCheck $?

PRINT "enable & restart Redis"
systemctl enable redis &>>$LOG && systemctl restart redis &>>$LOG
statusCheck $?