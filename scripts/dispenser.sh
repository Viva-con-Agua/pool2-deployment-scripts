#!/bin/bash
#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPathDispenser=$"${path}/conf/dispenser"

source ${path}/conf/setup.conf

dispenser_pull_docker(){
        echo "pull dispenser";
	docker pull vivaconagua/dispenser:$1;
}

dispenser_setup_database(){
        echo "setup dispenser database"; 
	docker run --net pool-network --ip $dispenser_db_mongo_ip --name dispenser-mongo --restart=unless-stopped -d mongo;
}

dispenser_rm_database(){
        echo "remove dispenser database";
	docker stop dispenser-mongo;
	docker rm dispenser-mongo;
}


dispenser_run_docker(){
        echo "setup dispesner";
	docker create --net pool-network --ip $dispenser_ip --name dispenser --restart=unless-stopped --link dispenser-mongo:mongo -p 5001:9000  vivaconagua/dispenser:${dispenser_version} \
		-Dplay.evolutions.db.default.autoApply=true \
		-Dplay.http.secret.key"ösjkadfhkjsadfaösjdfnisajdnfsöjkadfn" \
		-Dmongodb.uri=mongodb://mongo/dispenser \
		-Dconfig.resource=application.conf \
		-Ddispenser.hostURL=${hostUrl} \
		-Dplay.http.context="/dispenser"; 
	#docker cp ${confPath}/application.0.1.3-dev.conf dispenser:/opt/docker/conf/application.conf; 
	docker start dispenser;
}

dispenser_check_online(){
      ping -c1 $dispenser_ip > /dev/null && echo "true" || echo "false";
}

dispenser_set_navigation(){

      echo "set Navigation";
      docker cp ${confPathDispenser}/navigations/. dispenser:/opt/docker/conf/navigation/jsons/;
      curl -X GET http://${dispenser_ip}:9000/dispenser/navigation/init;
}



dispenser_rm_docker(){
         echo "remove dispenser";
	docker stop dispenser;
	docker rm dispenser;
}
dispenser_clean_up(){
   docker stop dispenser-mongo;
   docker stop dispenser;
   docker rm dispenser-mongo;
   docker rm dispenser;
}


