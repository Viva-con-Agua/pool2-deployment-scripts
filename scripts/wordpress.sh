#!/bin/bash

path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/pool1"


pool1_setup_db(){
	docker run --net pool-network --ip 172.2.1.10 --name pool1-mysql \
	-e MYSQL_ROOT_PASSWORD=root \
	-d mysql;
}
pool1_fpm_setup(){
	docker run --net pool-network --ip 172.2.0.9 --name pool1-fpm --link pool1 -d wordpress:4.9.0-php5.6-fpm;
}
pool1_setup_docker(){
	docker run --net pool-network --ip 172.2.0.10  --name pool1 --link pool1-mysql:mysql  \
	-e WORDPRESS_DB_HOST=mysql \
	-e WORDPRESS_DB_USER=root \
	-e WORDPRESS_DB_PASSWORD=root \
	-e WORDPRESS_DB_NAME=db175370026 \
	-e WORDPRESS_DB_TABLE_PREFIX=vca1312 \
	-d vivaconagua/pool1-docker:latest;	
}

pool1_rm_fpm(){
	docker stop pool1-fpm;
	docker rm pool1-fpm;
}
pool1_rm_db(){
	docker stop pool1-mysql;
	docker rm pool1-mysql;
}

pool1_rm_docker(){
	docker stop pool1;
	docker rm pool1;
}

case $1 in
	run)
		pool1_setup_docker
		pool1_fpm_setup
		;;
	rm) 
		pool1_rm_docker
		pool1_rm_fpm
		;;
	db)
		case $2 in
			run)
				pool1_setup_db
				;;
			rm)
				pool1_rm_db
				;;
			*)
			echo "Error"
	esac
		;;
	*)
		echo "Error"
esac
