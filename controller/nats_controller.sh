#!/bin/bash

#######################
#                     #
# controller for nats #
#                     #
#######################
source ${path}/scripts/nats.sh

nats_controller(){
  case $1 in  
    run)
  	 	setup_nats_docker
  	;;
  	stop)
  		docker stop pool-nats
  	;;
  	rm)
  		docker stop pool-nats
  		docker rm pool-nats
  	;;
  	logs)
  		docker logs pool-nats
  	;;
  	exec)
  		docker exec -it pool-oes bash
  	;;
  	*)
  		echo "ERROR"
  esac
}


