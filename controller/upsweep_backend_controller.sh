#!/bin/bash

##################################
#                                #
# controller for upsweep-backend #
#                                #
##################################

source ${path}/scripts/upsweep-backend.sh

upsweep_backend_controller(){
  case $1 in 
    db)
      case $2 in 
        run) upsweep_setup_database_docker;;
      esac
      ;;
  esac
}
