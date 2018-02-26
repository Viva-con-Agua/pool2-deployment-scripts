#!/bin/bash

########################################
#                                      #
# setup script for Pool² Version 0.0.1 #
#                                      #
########################################

path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
scripts=$"${path}/scripts/"

source ${path}/conf/setup.conf





setup_database(){
	# Drops Databases
	bash ${scripts}/database.sh run
}

setup_control_ms(){
	
	bash ${scripts}/dispenser.sh run
