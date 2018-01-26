#!/bin/bash
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/drops"

dispenser_pull_docker(){
	docker pull vivaconagua/dispenser:$1;
}

dispenser_setup_database(){
	docker run --net pool-network --ip 172.2.1.3 --name dispenser-mongo --restart=unless-stopped -d mongo;
}

dispenser_rm_database(){
	docker stop dispenser-mongo;
	docker rm dispenser-mongo;
}


dispenser_run_docker(){
	docker run --net pool-network --ip 172.2.0.5 --name dispenser --restart=unless-stopped --link dispenser-mongo:mongo -d vivaconagua/dispenser:0.1.13-test \
		-Dplay.evolutions.db.default.autoApply=true \
		-Dmongodb.uri=mongodb://mongo/dispenser \
		-Dconfig.resource=application.conf \
		-Ddrops.dropsURL='http://172.2.0.3/' \
		-Ddrops.redirectUrl="https://vca.informatik.hu-berlin.de/drops/oauth2/code/get/dispenser" \
		-Ddrops.getTokenUrl="" \
		-Ddrops.grant_type="authorization_code" \
		-Ddrops.client_id="dispenser" \
		-Ddrops.redirectUri="" \
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
				echo "read doku "
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
				echo "read doku"
		esac
		;;
	pull)
		dispenser_pull_docker $2
		;;
	db)
		case $2 in 
			run)
				dispenser_setup_database
			;;
			rm)
				dispenser_rm_database
			;;
		*)
			echo "read doku"
		esac
		;;
	*)
		echo $"Usage: $0 {run|start|stop|rm|db}"
esac
 
