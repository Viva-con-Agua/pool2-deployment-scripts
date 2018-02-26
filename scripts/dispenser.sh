#!/bin/bash
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/dispenser"

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
	docker create --net pool-network --ip 172.2.0.5 --name dispenser --restart=unless-stopped --link dispenser-mongo:mongo -p 5001:9000  vivaconagua/dispenser:0.2.3 \
		-Dplay.evolutions.db.default.autoApply=true \
		-Dplay.http.secret.key"ösjkadfhkjsadfaösjdfnisajdnfsöjkadfn" \
		-Dmongodb.uri=mongodb://mongo/dispenser \
		-Dconfig.resource=application.conf \
		-Ddispenser.hostURL="https://vca.informatik.hu-berlin.de/dispenser" \
		-Dplay.http.context="/dispenser"; 
	docker cp ${confPath}/application.0.1.3-dev.conf dispenser:/opt/docker/conf/application.conf; 
	docker start dispenser;
}

dispenser_rm_docker(){
	docker stop dispenser;
	docker rm dispenser;
}


case $1 in
	run)	
		dispenser_run_docker
	;;
	start)
		docker start dispenser
		;;
	stop) 
		docker stop dispenser
		;;
	rm)	
		dispenser_rm_docker
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
 
