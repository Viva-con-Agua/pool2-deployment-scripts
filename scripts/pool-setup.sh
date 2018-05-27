#!/bin/bash

########################################
#                                      #
# setup script for Pool² Version 0.0.1 #
#                                      #
########################################

path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
scripts=$"${path}/scripts/"

source ${path}/conf/setup.conf





setup_folder(){
  #create cert folder

  if [ ! -d "${path}/../cert" ]; then
      mkdir ${path}/../cert
      echo "setup cert folder"
  else
     echo "use existing cert folder"
  fi

  #copy password.conf
  
  if [ ! -f ${path}/../cert/password.conf ]; then
       echo "File not found!"
  fi
}

setup_database(){
	# Drops Databases
	bash ${scripts}/drops.sh db run;
        bash ${scripts}/dispenser db run;
        bash ${schript}/bloob db run;
}

setup_control_ms(){
	bash ${scripts}/dispenser.sh run;
        bash ${scripts}/nats.sh run;
}

case $1 in 
      
      setup)
         setup_folder
         setup_database
         setup_contol_ms
         ;;
      *)
      echo "error"
esac
