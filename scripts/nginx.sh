#!/bin/bash
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/nginx"
certPath=$"/home/pool/Pool/cert"
case $1 in
	run)
		docker run --net pool-network --ip 172.2.0.2 --name nginx-docker -p 443:443 -p 80:80 \
		-v ${confPath}/config:/etc/nginx/conf.d/ \
		-v ${confPath}/vca.informatik.hu-berlin.de.pem:/etc/nginx/vca.informatik.hu-berlin.de.pem \
		-v ${certPath}/vca.informatik.hu-berlin.de.chained.pem:/etc/nginx/vca.informatik.hu-berlin.de.chained.pem \
		-v ${confPath}/vca.informatik.hu-berlin.de.key:/etc/nginx/vca.informatik.hu-berlin.de.key \
		-v ${certPath}/global.pass:/etc/nginx/global.pass \
		-d nginx:1.12.1 'nginx-debug' '-g' 'daemon off;'
		;;
	start) 
		docker start nginx-docker
		;;
	stop)
		docker stop nginx-docker
		;;
	rm)
		docker stop nginx-docker
		docker rm nginx-docker
		;;
	logs)
		docker logs nginx-docker
		;;
	*)
		echo $"Usage: $0 {run|start|stop|rm}"
		exit 1
esac
	
	