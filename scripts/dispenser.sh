#!/bin/bash
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/drops"

case $1 in
	run)
		docker run --net pool-network --ip 172.2.0.5 --name dispenser -d vivaconagua/dispenser:0.1.13 \
		-Dplay.evolutions.db.default.autoApply=true \
		-Dconfig.resource=application.conf \
		-Dplay.http.context="/dispenser" 
		;;
	start)
		docker start dispenser
		;;
	stop) 
		docker stop dispenser
		;;
	rm)
		docker stop dispenser
		docker rm dispenser
		;;
	*)
		echo $"Usage: $0 {run|start|stop|rm|db}"
esac
 
