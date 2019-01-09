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
        dispenser_run_docker $dispenser_version
    ;;
    start)
        docker start dispenser
    ;;
    stop) 
        docker stop dispenser
    ;;
    rm)	
        dispenser_rm_docker
    ;;
    pull)
        dispenser_pull_docker $3
    ;;
    update)
	dispenser_update_docker
    ;;
    init)
        dispenser_set_navigation
    ;;
    db)
        case $3 in 
            run)
               dispenser_setup_database
            ;;
            rm)
               dispenser_rm_database
            ;;
            *)
                echo "read doku"
          esac
          ;;
    esac
}
