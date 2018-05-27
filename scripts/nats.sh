#!/bin/bash

##
# configs
##
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/nats"
VERSION=`cat ${confPath}/VERSION`

source ${path}/../pool2.conf
source ${certPath}/password.conf
source ${path}/conf/setup.conf



setup_nats_docker(){	
	docker run --net pool-network --ip $nats_ip -d --restart=unless-stopped -p 5000:8222 --name pool-nats nats:${nats_version};
}


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
	;;
esac
