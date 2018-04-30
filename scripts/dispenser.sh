#!/bin/bash
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/dispenser"

source ${path}/../conf/setup.conf

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
	docker create --net pool-network --ip $dispenser_ip --name dispenser --restart=unless-stopped --link dispenser-mongo:mongo -p 5001:9000  vivaconagua/dispenser:${1} \
		-Dplay.evolutions.db.default.autoApply=true \
		-Dplay.http.secret.key"ösjkadfhkjsadfaösjdfnisajdnfsöjkadfn" \
		-Dmongodb.uri=mongodb://mongo/dispenser \
		-Dconfig.resource=application.conf \
		-Ddispenser.hostURL="https://vca.informatik.hu-berlin.de" \
		-Dplay.http.context="/dispenser"; 
	#docker cp ${confPath}/application.0.1.3-dev.conf dispenser:/opt/docker/conf/application.conf; 
	docker start dispenser;
}

dispenser_set_navigation(){
  docker cp ${confPath}/navigations/. dispenser:/opt/docker/conf/navigation/jsons/
  curl -X GET http://${dispenser_ip}:9000/dispenser/navigation/init


}

dispenser_rm_docker(){
	docker stop dispenser;
	docker rm dispenser;
}

case $1 in

	run)	
		dispenser_run_docker $dispenser_version
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
        init)
                dispenser_set_navigation
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
 
