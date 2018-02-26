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
	docker run --net pool-network --ip $drops.db.mongo.ip --name drops-mongo --restart=unless-stopped -d mongo;
        docker run --net pool-network --ip $drops.db.maria.ip --name drops-mariadb --restart=unless-stopped \
                -e MYSQL_ROOT_PASSWORD=drops \
                -e MYSQL_DATABASE=drops \
                -e MYSQL_USER=drops \
                -e MYSQL_PASSWORD=drops \
                -e MYSQL_ROOT_PASSWORD=yes \
                -d mariadb:latest;
}

##
# setup dispenser database
##
database_setup_dispenser(){
	docker run --net pool-network --ip $dispenser.db.mongo.ip --name dispenser-mongo --restart=unless-stopped -d mongo;
}

##
# setup pool1 database
##
database_setup_pool(){
	docker run --net pool-network --ip $pool.db.maria.ip --mount source=pool1-db-files,destination=/var/lib/mysql/ --restart=unless-stopped --name pool1-mysql \
        -e MYSQL_ROOT_PASSWORD=root \
        -d mysql;
	
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
