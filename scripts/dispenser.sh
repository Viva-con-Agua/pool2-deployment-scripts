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

dispenser_update_docker(){
	docker pull vivaconagua/dispenser:${dispenser_version};
	dispenser_rm_docker;
	dispenser_run_docker;
}

dispenser_run_docker(){
        echo "setup dispesner";
	docker run --net pool-network --ip $dispenser_ip --name dispenser --restart=unless-stopped --link dispenser-mongo:mongo -v ${confPathDispenser}/application.conf:/opt/docker/conf/application.conf -d vivaconagua/dispenser:${dispenser_version} \
		-Dconfig.resource=application.conf \
		-Dplay.http.secret.key=${dispenser_secret} \
		-Dmongodb.uri=mongodb://mongo/dispenser \
		-Dconfig.resource=application.conf \
		-Ddispenser.hostURL=${hostUrl} \
     		-Dms.name="DISPENSER" \
    -Dms.host="https://${hostname}/dispenser" \
    -Dms.entrypoint="/authenticate/drops" \
    -Ddrops.url.base="https://${hostname}/drops" \
    -Ddrops.client_id="dispenser" \
    -Ddrops.client_secret="${dispenser_secret_oauth}" \
   -Dplay.http.context="/dispenser"; 
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
	docker rm -f dispenser;
}
dispenser_clean_up(){
   docker stop dispenser-mongo;
   docker stop dispenser;
   docker rm dispenser-mongo;
   docker rm dispenser;
}


