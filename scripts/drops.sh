#!/bin/bash
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/drops"
VERSION=`cat ${confPath}/VERSION`

source ${path}/../pool2.conf
source ${certPath}/password.conf
source ${path}/conf/setup.conf

# setup the drops docker with
drops_setup_docker(){
	docker run --net pool-network --ip $drops_ip -h drops.vca --name drops --restart=unless-stopped --link mail-docker:mail --link drops-mongo:mongo --link drops-mariadb:mariadb -d vivaconagua/drops:${1} \
		-Dplay.crypto.secret=$drops_secret \
		-Dplay.evolutions.enabled=false \
		-Dplay.evolutions.db.default.autoApply=true \
		-Dconfig.resource=application.conf \
		-Dplay.evolutions.autoApply=true \
		-Dplay.http.context="/drops" \
		-Dlogin.flow.ms.switch=true \
		-Dlogin.flow.ms.url=https://vca.informatik.hu-berlin.de/pool \
		-Dmongodb.uri=mongodb://mongo/drops \
		-Dslick.dbs.default.db.url=jdbc:mysql://mariadb/drops \
		-Dslick.dbs.default.db.user=drops \
		-Dslick.dbs.default.db.password=drops \
		-Dmail.smtp.host=mail:25 \
		-Dplay.mailer.mock=no \
		-Dplay.mailer.host=mailbox.informatik.hu-berlin.de \
		-Dplay.mailer.user=$smtp_user \
		-Dplay.mailer.password=$smtp_password \
		-Dpool1.export=false \
		-Dnats.ip="nats://${nats_ip}:4222" \
		-Ddispenser.ip="http://${dispenser_ip}:9000/dispenser/" \
		-Dpool1.url="https://vca.informatik.hu-berlin.de/pool?loginFnc=usercreate" 
}

#setup docker for dev system. Without mailer!!!! Mails over pool logs drops
drops_setup_dev_docker(){
	docker run --net pool-network --ip $drops_ip -h drops.vca --name drops --restart=unless-stopped --link mail-docker:mail --link drops-mongo:mongo --link drops-mariadb:mariadb -d vivaconagua/drops:${1} \
		-Dplay.crypto.secret=$drops_secret \
		-Dplay.evolutions.enabled=false \
		-Dplay.evolutions.db.default.autoApply=true \
		-Dconfig.resource=application.conf \
		-Dplay.evolutions.autoApply=true \
		-Dplay.http.context="/drops" \
		-Dlogin.flow.ms.switch=true \
		-Dlogin.flow.ms.url=https://vca.informatik.hu-berlin.de/pool \
		-Dmongodb.uri=mongodb://mongo/drops \
		-Dslick.dbs.default.db.url=jdbc:mysql://mariadb/drops \
		-Dslick.dbs.default.db.user=drops \
		-Dslick.dbs.default.db.password=drops \
		-Dpool1.export=true \
		-Dnats.ip="nats://${nats_ip}:4222" \
		-Ddispenser.ip="http://${dispenser_ip}:9000/dispenser/" \
		-Dpool1.url="https://vca.informatik.hu-berlin.de/pool?loginFnc=usercreate" 
}


# start drops docker
drops_start_docker(){
	docker start drops;
}
# remove drops docker
drops_remove_docker(){
	docker stop drops;
	docker rm drops;
}

# setup drops db docker
drops_db_setup_docker(){
	docker run --net pool-network --ip $drops_db_mongo_ip --name drops-mongo --restart=unless-stopped -d mongo;
	docker run --net pool-network --ip $drops_db_maria_ip --name drops-mariadb --restart=unless-stopped \
		-e MYSQL_ROOT_PASSWORD=drops \
	    	-e MYSQL_DATABASE=drops \
    		-e MYSQL_USER=drops \
    		-e MYSQL_PASSWORD=drops \
    		-e MYSQL_ROOT_PASSWORD=yes \
    		-d mariadb:latest;

}

drops_db_stop_docker(){
	docker stop drops-mariadb
	docker stop drops-mongo
}

drops_db_start_docker(){
	docker start drops-mongo;
	docker start drops-mariadb;	
}

drops_db_remove_docker(){
	cdate=$"date +%Y-%m-%d-%H-%M"
	docker exec -it drops-mongo mongodump --db drops &
	wait &!
	docker cp drops-mongo:/dump/ /home/pool/
	gzip /home/pool/backup/drops /home/pool/backup/drops_mongo_${cdate}.gzip
}

drops_pull_docker(){
      docker pull vivaconagua/drops:${1};
}





case $1 in
	run)	
		if [ -z "$2" ]; then 
			drops_setup_docker $drops_version
		else
			drops_setup_docker $2
		fi
		;;
        dev)
               if [ -z "$2" ]; then 
			drops_setup_dev_docker $drops_version
		else
			drops_setup_dev_docker $2
		fi
		;;

	backup)
		drops_db_remove_docker
		;;
	reset)
		drops_remove_docker
		if [ -z "$2" ]; then 
			drops_setup_docker ${VERSION}
		else
			drops_setup_docker $2
		fi
		;;
	start)
		docker start drops
		;;
	stop) 
		docker stop drops
		;;
	rm)
		drops_remove_docker
		;;
	logs)
		docker logs drops
		;;
        pull)
                if [ -z "$2" ]; then
                     drops_pull_docker $drops_version
                else
                     drops_pull_docker $2
                fi
                ;;
	db)
		case $2 in
			run)	
				drops_db_setup_docker
				;;
			start)
				docker start drops-mongo
				docker start drops-mariadb
				;;
			stop) 
				docker stop drops-mongo
				docker stop drops-mariadb
				;;
			rm)
				docker stop drops-mongo
				docker stop drops-mariadb
				docker rm drops-mongo
				docker rm drops-mariadb
				;;
			*)
				echo $"Usage: $0 {run|start|stop|rm}"
		esac
		;;
	*)
		echo $"Usage: $0 {run|start|stop|rm|db}"
esac
 
