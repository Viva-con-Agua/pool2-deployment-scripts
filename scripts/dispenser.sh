#!/bin/bash
#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPathDispenser=$"${path}/conf/dispenser"

source ${path}/conf/setup.conf
source ${path}/conf/password.conf

dispenser_pull(){
    echo "pull dispenser";
    docker pull vivaconagua/dispenser:$1;
}

dispenser_setup_database_docker(){
    echo "setup dispenser database"; 
	  docker run --net pool-network --ip $dispenser_db_mongo_ip --name dispenser-mongo --restart=unless-stopped -d mongo;
}

dispenser_remove_database(){
    echo "remove dispenser database";
    docker stop dispenser-mongo;
	  docker rm dispenser-mongo;
}

dispenser_update(){
	docker pull vivaconagua/dispenser:${dispenser_version};
	dispenser_remove;
  dispenser_run;
}

dispenser_run(){
        echo "setup dispesner";
	docker run --net pool-network --ip $dispenser_ip --name dispenser --restart=unless-stopped --link dispenser-mongo:mongo  -d vivaconagua/dispenser:${dispenser_version} \
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


dispenser_set_navigation(){
      #if nc -z $dispenser_ip 9000; then
         echo "set Navigation";
         docker cp ${confPathDispenser}/navigations/. dispenser:/opt/docker/conf/navigation/jsons/;
         curl -X GET http://${dispenser_ip}:9000/dispenser/navigation/init;
      #else
      #   dispenser_set_navigation
  #fi;
}


dispenser_restart(){
  echo "restart dispenser"
  remove=$(docker rm -f dispenser)
  case $remove in
    dispenser)
      echo "dispenser successfull removed";
      dispenser_run && echo "dispenser successful restarted" || echo "ERROR: dispenser can't start again. Try pool run dispenser to start the service";
    ;;
    *) echo "ERROR: dispenser is maybe not running. Try pool run dispenser"
  esac
}

dispenser_remove(){
         echo "remove dispenser";
	docker rm -f dispenser;
}

dispenser_clean(){
   docker stop dispenser-mongo;
   docker stop dispenser;
   docker rm dispenser-mongo;
   docker rm dispenser;
}


