#!/bin/bash

sluice_setup_docker(){
	docker run --net pool-network --ip 172.2.0.7  --name sluice vivaconagua/sluice:latest
}

sluice_stop_docker(){
	docker stop sluice
}

sluice_rm_docker(){
	docker stop sluice
	docker rm sluice
}

