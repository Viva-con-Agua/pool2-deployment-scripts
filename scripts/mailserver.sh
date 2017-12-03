#!/bin/bash

confPath=$"/home/pool/Pool/conf/nginx"
certPath=$"/home/pool/Pool/cert"

mailserver_setup(){
	docker run --net pool-network --ip 172.2.0.4 \
	 -e POSTFIX_myhostname=vca.informatik.hu-berlin.de \
    	--name mail-docker \
    	-d mwader/postfix-relay;
}
case $1 in
	run)	
		mailserver_setup
		;;
	start) 
		docker start mail-docker
		;;
	stop)
		docker stop mail-docker
		;;
	rm)
		docker stop mail-docker
		docker rm mail-docker
		;;
	logs)
		docker logs mail-docker
		;;
	*)
		echo $"Usage: $0 {run|start|stop|rm}"
		exit 1
esac
	
	
