#!/bin/bash

########################
#                      #
# controller for drops #
#                      #
########################
source ${path}/scripts/wordpress.sh

pool1_controller(){
  case $1 in
    run)
      shift  
      while getopts ":dpvD" option; do
        case ${option} in
          D) pool1_setup_db; exit 1;;
        esac
      done
      case ${deploy} in
        prod) pool1_setup_docker;;
        dev) pool1_setup_docker;;
     esac 
    ;;
    restart)
       case ${deploy} in
          prod) docker rm -f pool1-docker; pool1_setup_docker;;
          dev) docker rm -f pool1-docker; pool1_setup_docker;;
       esac
       ;;
    rm) 
      shift
      while getopts ":D" option; do
        case ${option} in
          D) pool1_rm_db exit 1;;
        esac
      done 
      pool1_rm_docker
      ;;
    
    logs) docker logs pool1-docker;;
 	echo $"Usage: $0 {run|start|stop|rm}"
 esac
}
