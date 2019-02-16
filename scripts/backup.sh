#!/bin/bash

confPath=$"${path}/conf/backup"

setup_pool1_backup(){
	docker run  --net pool-network --ip $pool1_backup_ip --name pool1-backup --restart=unless-stopped -d -v ${path}/../../backup/pool1:/db --env-file ${confPath}/pool1-backup.env  \
		deitch/mysql-backup
}

setup_drops_backup(){
	docker run  --net pool-network --ip $drops_backup_ip --name drops-backup --restart=unless-stopped -d -v ${path}/../../backup/drops:/db --env-file ${confPath}/drops-backup.env  \
		deitch/mysql-backup
}
