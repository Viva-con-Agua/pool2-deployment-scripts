#!/bin/bash

#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPathPool1=$"${path}/conf/pool1"


pool1_setup_db(){
	docker run --net pool-network --ip 172.2.1.10 --mount source=pool1-db-files,destination=/var/lib/mysql/ --restart=unless-stopped --name pool1-mysql \
	-e MYSQL_ROOT_PASSWORD=root \
	-d mysql;
}
pool1_setup_docker(){
	docker run --net pool-network --ip 172.2.0.10 --mount source=pool1-files,destination=/var/www/html/pool/ --restart=unless-stopped --name pool1 --link pool1-mysql:mysql  \
	-e WORDPRESS_DB_HOST=mysql \
	-e WORDPRESS_DB_USER=root \
	-e WORDPRESS_DB_PASSWORD=root \
	-e WORDPRESS_DB_NAME=db175370026 \
	-e WORDPRESS_DB_TABLE_PREFIX=vca1312 \
	-d wordpress:4.7.1-php7.0-apache;	
}

pool1_rm_db(){
	docker stop pool1-mysql;
	docker rm pool1-mysql;
}

pool1_rm_docker(){
	docker stop pool1;
	docker rm pool1;
}


