#!/bin/bash

confPath=$"/home/pool/Pool/conf/nginx"
certPath=$"/home/pool/Pool/cert"
case $1 in
	run)
		docker run --net pool-network --ip 172.2.0.4 -h smtp.vca.com --name mail-docker -d\
		-e SMTP_LOGIN=drops \
		-e SMTP_PASSWORD=drops \
      		b32147/smtp-relay
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
	
	
