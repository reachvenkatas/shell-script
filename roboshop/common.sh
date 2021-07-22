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
  echo -n -e "$1\t\t\t..."
}

