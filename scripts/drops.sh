#!/bin/bash
confPathDrops=$"${path}/conf/drops"

source ${path}/conf/setup.conf

# setup the drops docker with
drops_setup_docker(){
        echo "setup Drops";
	docker run --net pool-network --ip $drops_ip -h drops.vca --name drops --restart=unless-stopped --link mail-docker:mail  --link drops-mariadb:mariadb -d vivaconagua/drops:${drops_version} \
		-Dplay.crypto.secret=$drops_secret \
		-Dplay.evolutions.enabled=true \
		-Dplay.evolutions.db.default.autoApply=true \
		-Dconfig.resource=application.conf \
		-Dplay.evolutions.autoApply=true \
		-Dplay.http.context="/drops" \
    -Dwebapp.host="https://${hostname}" \
		-Dlogin.flow.ms.switch=true \
		-Dlogin.flow.ms.url="https://${hostname}/pool" \
		-Dslick.dbs.default.db.url=jdbc:mysql://mariadb/drops \
		-Dslick.dbs.default.db.user=drops \
		-Dslick.dbs.default.db.password=drops \
		-Dmail.smtp.host=smtp.arfiles.de \
		-Dplay.mailer.mock=no \
		-Dplay.mailer.host=smtp.artfiles.de \
		-Dplay.mailer.user=$smtp_user \
		-Dplay.mailer.password=$smtp_password \
		-Dpool1.export=true \
		-Dpool1.base="https://${hostname}/pool/" \
		-Dnats.ip="nats://${nats_ip}:4222" \
		-Ddispenser.ip="http://${dispenser_ip}:9000/dispenser/" \
		-Dpool1.url="https://${hostname}/pool/?api=user&action=create" 
}

#setup docker for dev system. Without mailer!!!! Mails over pool logs drops

drops_setup_dev_docker(){
	echo "setup Drops in dev mode";
	docker run --net pool-network --ip $drops_ip -h drops.vca --name drops --restart=unless-stopped --link mail-docker:mail --link drops-mariadb:mariadb -d vivaconagua/drops:${drops_version} \
		-Dplay.crypto.secret=$drops_secret \
		-Dplay.evolutions.enabled=true \
		-Dplay.evolutions.db.default.autoApply=true \
		-Dconfig.resource=application.conf \
		-Dplay.evolutions.autoApply=true \
		-Dplay.http.context="/drops" \
		-Dlogin.flow.ms.switch=false \
		-Dlogin.flow.ms.url=https://vca.informatik.hu-berlin.de/pool \
		-Dslick.dbs.default.db.url=jdbc:mysql://mariadb/drops \
		-Dslick.dbs.default.db.user=drops \
		-Dslick.dbs.default.db.password=drops \
		-Dpool1.export=false \
		-Dnats.ip="nats://${nats_ip}:4222" \
		-Ddispenser.ip="http://${dispenser_ip}:9000/dispenser/" \
		-Dpool1.url="https://vca.informatik.hu-berlin.de/pool/?api=user&action=create"
}


# start drops docker
drops_start_docker(){
         echo "start Drops";
	docker start drops;
}
# remove drops docker
drops_remove_docker(){
         echo "remove Drops";
	docker rm -f drops;
}

drops_update_docker(){
	docker pull vivaconagua/drops:${drops_version};
	docker rm -f drops;
	drops_setup_docker;

}

# setup drops db docker
drops_db_setup_docker(){
        echo "setup Drops database";
	docker run --net pool-network --ip $drops_db_maria_ip --name drops-mariadb --restart=unless-stopped \
		-e MYSQL_ROOT_PASSWORD=drops \
	    	-e MYSQL_DATABASE=drops \
    		-e MYSQL_USER=drops \
    		-e MYSQL_PASSWORD=drops \
    		-e MYSQL_ROOT_PASSWORD=yes \
    		-d mariadb:latest;

}

drops_restart_database(){
  drops_db_remove_docker
  drops_db_setup_docker
}

drops_db_stop_docker(){
         echo "stop Drops database";
	docker stop drops-mariadb
}

drops_db_start_docker(){
         echo "start Drops database";
	docker start drops-mariadb;	
}

drops_db_remove_docker(){
  docker rm -f drops-mariadb
}

drops_pull_docker(){
      docker pull vivaconagua/drops:${drops_version};
}

drops_clean_up(){
   docker stop drops-mariadb;
   docker stop drops-mongo;
   docker stop drops;
   docker rm drops-mariadb;
   docker rm drops-mongo;
   docker rm drops;
}




