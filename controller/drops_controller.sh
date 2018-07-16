#!/bin/bash

########################
#                      #
# controller for drops #
#                      #
########################
source ${path}/scripts/drops.sh

drops_controller(){
  case $1 in
    run)
      shift  
      while getopts ":dpvD" option; do
        case ${option} in
          v) drops_version=${OPTARG};; 
          d) drops_setup_dev_docker; exit 1;;
          p) drops_setup_docker; exit 1;;
          D) drops_db_setup_docker; exit 1;;
        esac
      done
      drops_setup_dev_docker 
    ;;
    backup) drops_db_remove_docker;;
    reset)
      shift  
      drops_remove_docker
      while getopts ":dpv" option; do
        case ${option} in
          v) drops_version=${OPTARG};;
          d) drops_setup_dev_docker; exit 1;;
          p) drops_setup_docker; exit 1;;
        esac
      done
      ;;

    
    start) docker start drops;;
   
    stop) docker stop drops;;
  
    rm) 
      shift
      while getopts ":D" option; do
        case ${option} in
          D) docker rm -f drops-mongo; docker rm -f drops-mariadb; exit 1;;
        esac
      done 
      drops_remove_docker
      ;;
    
    logs) docker logs drops;;
    pull)
      shift
      while getopts ":v" option; do
        case ${option} in
          v) drops_version=${OPTARG};;
        esac
      done
      drops_pull_docker
      ;;
 		*)
 			echo $"Usage: $0 {run|start|stop|rm}"
 	esac
}
