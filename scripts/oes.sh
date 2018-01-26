#!/bin/bash

setup_oes_docker(){	
	docker run --net pool-network --ip 172.2.100.2 -d --restart=unless-stopped -p 5000:8222 --name pool-oes nats;
}


case $1 in 
	run)
		setup_oes_docker
	;;
	stop)
		docker stop pool-oes
	;;
	rm)
		docker stop pool-oes
		docker rm pool-oes
	;;
	logs)
		docker logs pool-oes
	;;
	exec)
		docker exec -it pool-oes bash
	;;
	*)
		echo "ERROR"
	;;
esac
