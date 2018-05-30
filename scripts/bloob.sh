#!/bin/bash
#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

source ${path}/conf/setup.conf
source ${path}/pool2.conf
source ${certPath}/password.conf

bloob_db_setup(){
   echo "setup bloob database";
   docker run --net pool-network --ip $bloob_db_maria_ip --name bloob-maria --restart=unless-stopped \
      		-e MYSQL_ROOT_PASSWORD=bloob \
	    	-e MYSQL_DATABASE=bloob \
    		-e MYSQL_USER=bloob \
    		-e MYSQL_PASSWORD=bloob \
    		-e MYSQL_ROOT_PASSWORD=yes \
    		-d mariadb:latest;
}

bloob_setup_docker(){   
   echo "setup bloob";
   docker run --net pool-network --ip $bloob_ip --name bloob --restart=unless-stopped --link bloob-maria:mariadb -d vivaconagua/bloob:${1} \
      -Dplay.crypto.secret=$bloob_secret \
      -Dplay.http.context="/bloob" \
      -Dplay.evolutions.enabled=true \
      -Dplay.evolutions.db.default.autoApply=true \
      -Dslick.dbs.default.db.url=jdbc:mysql://mariadb/bloob \
      -Dslick.dbs.default.db.user=bloob \
      -Dslick.dbs.default.db.password=bloob \
      -Dnats.endpoint="nats://${nats_ip}:4222";

}


