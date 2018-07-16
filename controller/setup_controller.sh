#!/bin/bash

########################
#                      #
# controller for setup #
#                      #
########################
source ${path}/scripts/setup.sh

setup_controller(){
  case $1 in 
    dev)
       setup_pool_dev
       ;;
    clean)
       delete_pool_docker
    ;;
    restart)
       delete_pool_docker
       setup_pool_dev
    ;; 
    cleanfull)
       delete_pool_docker_full
    ;;
    *)
       echo "error"
  esac
}

