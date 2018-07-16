#!/bin/bash

########################
#                      #
# controller for bloob #
#                      #
########################
source ${path}/scripts/bloob.sh



bloob_controller(){
  case $1 in 
    run)
       if [ -z "$3" ]; then
          bloob_setup_docker $bloob_version
       else
          bloob_setup_docker $3
       fi
       ;;
    rm)
       docker stop bloob
       docker rm bloob
       ;;
    logs)
       docker logs bloob
       ;;
    db)
       bloob_db_setup
       ;;
    *)
    echo $"Usage: $0 {run|rm|logs}"
  esac

}
