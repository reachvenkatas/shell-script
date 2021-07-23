#! /bin/bash

LOG=/tmp/frontend.log
#mv $LOG /tmp/backup/$LOG_$(date +%F-%T).log
rm -f $LOG

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ];  then
  echo -e "\e[31myou should be root user/ you should be sudo user to run this script\e[0m"
  exit 2
fi
statusCheck() {
if  [ $? -eq 0 ]; then
  echo -e "\e[32mdone\e[0m"
else
  echo -e "\e[31mfail\e[0m"
  exit 1
fi
}
PRINT() {
  echo -e "##################\t$1\t##################" &>>$LOG
  echo -n -e "$1\t\t\t\t..."
}

### COMMON CODE FOR ALl the micro services ###

NODEJS()  {
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
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG
statusCheck $?

PRINT "Extract downloaded code"
cd /home/roboshop && unzip -o /tmp/${COMPONENT}.zip &>>$LOG && rm -rf ${COMPONENT} && mv ${COMPONENT}-main ${COMPONENT}
cd /home/roboshop/${COMPONENT} && npm install --unsafe-perm &>>$LOG
statusCheck $?

PRINT "Install nodeJS dependencies"
cd /home/roboshop/${COMPONENT} && npm install --unsafe-perm &>>$LOG
statusCheck $?

PRINT "Fix Application Permissions"
chown roboshop:roboshop /home/roboshop -R &>>$LOG
statusCheck $?

PRINT "Update SystemD File"
sed -i -e "s/MONGO_DNSNAME/mongodb.roboshop.internal/" -e "s/REDIS_ENDPOINT/redis.roboshop.internal/" -e "s/MONGO_ENDPOINT/mongodb.roboshop.internal/" /home/roboshop/${COMPONENT}/systemd.service && mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>$LOG
statusCheck $?

PRINT "daemon-reload"
systemctl daemon-reload &>>$LOG
statusCheck $?

PRINT "start service"
systemctl start ${COMPONENT} &>>$LOG
statusCheck $?

PRINT "enable service"
systemctl enable ${COMPONENT} &>>$LOG
statusCheck $?

}



