#!/bin/bash

setup_docker_volume(){
	docker volume create $1;	
}


case $1 in 
	create)
		setup_docker_volume $2
	;;
	*)
		echo "error"
esac
