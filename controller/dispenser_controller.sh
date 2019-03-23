#!/bin/bash

############################
#                          #
# controller for dispenser #
#                          #
############################
source ${path}/scripts/dispenser.sh


dispenser_controller(){
  case $1 in
    run)
      shift
      while getopts ":vD" option; do
        case ${option} in
          v) drops_version=${OPTARG};;
          D) dispenser_run_database; exit 0;;
        esac
      done 
      dispenser_run $dispenser_version
    ;;
    start)
        docker start dispenser
    ;;
    stop) 
        docker stop dispenser
    ;;
    rm)	
      shift
      while getopts ":D" option; do
        case ${option} in
          D) dispenser_remove_database; exit 0;;
        esac
      done
     dispenser_remove
    ;;
    pull)
        dispenser_pull $3
    ;;
    update)
	    dispenser_update
    ;;
    init)
        dispenser_set_navigation
    ;;
    restart)
        dispenser_restart
    ;;
    esac
}
