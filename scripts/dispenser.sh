#!/bin/bash
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/drops"

dispenser_pull_docker(){
	docker pull vivaconagua/dispenser:$1;
}

dispenser_run_docker(){
	docker run --net pool-network --ip 172.2.0.5 --name dispenser -d vivaconagua/dispenser:0.1.13-dev \
		-Dplay.evolutions.db.default.autoApply=true \
		-Dconfig.resource=application.conf \
		-Dplay.http.context="/dispenser"; 
}

dispenser_rm_docker(){
	docker stop dispenser;
	docker rm dispenser;
}

dispenser-assets_run_docker(){
	docker run --net pool-network --ip 172.2.0.6 --name dispenser-assets -d vivaconagua/dispenser-assets:latest;
}
dispenser-assets_rm_docker(){
	docker stop dispenser-assets;
	docker rm dispenser-assets;
}

case $1 in
	run)	
		case $2 in
			all)
				dispenser_run_docker
				dispenser-assets_run_docker
			;;
			dispenser)
				dispenser_run_docker
			;;
			assets)
				dispenser-assets_run_docker
			;;
			*)
				echo"read doku "
		esac
		;;
	start)
		docker start dispenser
		;;
	stop) 
		docker stop dispenser
		;;
	rm)	
		case $2 in 
			all)
				dispenser_rm_docker
				dispenser-assets_rm_docker
			;;
			dispenser)
				dispenser_rm_docker
			;;
			assets)
				dispenser-assets_run_docker
			;;
			*)
				echo"read doku"
		esac
		;;
	pull)
		dispenser_pull_docker
		;;
	*)
		echo $"Usage: $0 {run|start|stop|rm|db}"
esac
 
