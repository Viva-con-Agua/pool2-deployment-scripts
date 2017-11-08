#!/bin/bash
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/drops"

# setup the drops docker with
drops_setup_docker(){
	docker run --net pool-network --ip 172.2.0.3 --name drops --link mail-docker:mail --link drops-mongo:mongo --link drops-mariadb:mariadb -d vivaconagua/drops:0.17.10 \
		-Dplay.evolutions.db.default.autoApply=true \
		-Dconfig.resource=application.conf \
		-Dplay.http.context="/drops" \
		-Dmongodb.uri=mongodb://mongo/drops \
		-Dslick.dbs.default.db.url=jdbc:mysql://mariadb/drops \
		-Dslick.dbs.default.db.user=drops \
		-Dslick.dbs.default.db.password=drops \
		-Dmail.smtp.host=mail:25 \
		-Dplay.mailer.mock=no \
		-Dplay.mailer.host=smtp.vca.com \
		-Dplay.mailer.user=drops \
		-Dplay.mailer.password=drops;

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
	docker run --net pool-network --ip 172.2.2.1 --name drops-mongo --restart=unless-stopped -d mongo;
	docker run --net pool-network --ip 172.2.1.2 --name drops-mariadb --restart=unless-stopped \
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





case $1 in
	run)
		setup_drops_docker
		;;
	backup)
		drops_db_remove_docker
		;;
	reset)
		remove_drops_docker
		setup_drops_docker
		;;
	start)
		docker start drops
		;;
	stop) 
		docker stop drops
		;;
	rm)
		remove_drops_docker
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
 
