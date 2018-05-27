#!/bin/bash

##
# config path
##
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
scripts=$"${path}/scripts/"
source ${path}/../conf/setup.conf


##
# setup drops database
##
database_setup_drops(){
	docker run --net pool-network --ip $drops_db_mongo_ip --name drops-mongo --restart=unless-stopped -d mongo;
        docker run --net pool-network --ip $drops_db_maria_ip --name drops-mariadb --restart=unless-stopped \
                -e MYSQL_ROOT_PASSWORD=drops \
                -e MYSQL_DATABASE=drops \
                -e MYSQL_USER=drops \
                -e MYSQL_PASSWORD=drops \
                -e MYSQL_ROOT_PASSWORD=yes \
                -d mariadb:latest;
}

database_start_drops(){
       docker start drops-mongo;
       docker start drops-mariadb;
}

##
# setup dispenser database
##
database_setup_dispenser(){
	docker run --net pool-network --ip $dispenser_db_mongo_ip --name dispenser-mongo --restart=unless-stopped -d mongo;
}

database_start_dispenser(){
        docker start dispenser_mongo;
}

##
# setup pool1 database
##
database_setup_pool(){
	docker run --net pool-network --ip $pool_db_maria_ip --mount source=pool1-db-files,destination=/var/lib/mysql/ --restart=unless-stopped --name pool1-mysql \
        -e MYSQL_ROOT_PASSWORD=root \
        -d mysql;
	
}

database_start_pool(){
       docker 
}
##
# param definition
##


case $1 in
	run)
		if [ -z "$2" ]; then
			database_setup_drops
			database_setup_dispenser
			database_setup_pool
		else
			case $2 in
				drops)
					database_setup_drops
				;;
				dispenser)
					database_setup_dispenser
				;;
				pool)
					database_setup_pool
				;;
				*)
					echo "database not found "
			esac
		fi
esac
