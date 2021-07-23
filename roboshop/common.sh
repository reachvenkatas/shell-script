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

ADD_APPLICATION_USER() {
  PRINT "Add RoboShop Application User"
  id roboshop &>>$LOG
  if [ $? -ne 0 ]; then
    useradd roboshop &>>$LOG
  fi
  statusCheck $?
}

DOWNLOAD_APP_CODE() {
  PRINT "Download Application Code"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG
  statusCheck $?

  PRINT "Extract Downloaded Code\t"
  cd /home/roboshop && unzip -o  /tmp/${COMPONENT}.zip &>>$LOG  && rm -rf ${COMPONENT} && mv ${COMPONENT}-main ${COMPONENT}
  statusCheck $?
}

PERM_FIX() {
  PRINT "Fix Application Permissions"
  chown roboshop:roboshop /home/roboshop -R &>>$LOG
  statusCheck $?
}

SETUP_SYSTEMD() {
  PRINT "Setup SystemD file\t"
  sed -i -e "s/MONGO_DNSNAME/mongodb.roboshop.internal/" -e "s/REDIS_ENDPOINT/redis.roboshop.internal/" -e "s/MONGO_ENDPOINT/mongodb.roboshop.internal/" -e "s/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/" -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTHOST/cart.roboshop.internal/' -e 's/USERHOST/user.roboshop.internal/' -e 's/AMQPHOST/rabbitmq.roboshop.internal/'  /home/roboshop/${COMPONENT}/systemd.service && mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
  statusCheck $?

  PRINT "Start ${COMPONENT} Service\t"
  systemctl daemon-reload &>>$LOG && systemctl restart ${COMPONENT} &>>$LOG && systemctl enable ${COMPONENT} &>>$LOG
  statusCheck $?
}


NODEJS()  {
  PRINT "Install NodeJS\t\t"
  yum install nodejs make gcc-c++ -y &>>$LOG
  STAT_CHECK $?

  ADD_APPLICATION_USER
  DOWNLOAD_APP_CODE

  PRINT "Install NodeJS Dependencies"
  cd /home/roboshop/${COMPONENT} && npm install --unsafe-perm &>>$LOG
  STAT_CHECK $?

  PERM_FIX
  SETUP_SYSTEMD
}

JAVA() {
  PRINT "Install Maven\t\t"
  yum install maven -y &>>$LOG
  STAT_CHECK $?

  ADD_APPLICATION_USER
  DOWNLOAD_APP_CODE

  PRINT "Compile Code\t\t"
  cd /home/roboshop/${COMPONENT} && mvn clean package &>>$LOG &&  mv target/shipping-1.0.jar shipping.jar
  STAT_CHECK $?

  PERM_FIX
  SETUP_SYSTEMD
}



