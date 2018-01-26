#!/bin/bash

path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/backup"
compose=$"${path}/compose/"

setup_pool1_backup(){
	#docker-compose -f ${compose}pool1-backup.yml; 
	docker run  --net pool-network --ip 172.2.200.1 --name pool1-backup --restart=unless-stopped -d -v ${path}/../../backup/pool1:/db --env-file ${confPath}/pool1-backup.env  \
		deitch/mysql-backup
}

setup_drops_backup(){
	#docker-compose -f ${compose}pool1-backup.yml; 
	docker run  --net pool-network --ip 172.2.200.2 --name drops-backup --restart=unless-stopped -d -v ${path}/../../backup/drops:/db --env-file ${confPath}/drops-backup.env  \
		deitch/mysql-backup
}


case $1 in 
	run)
		case $2 in
			pool1)
				setup_pool1_backup
			;;
			drops)
				setup_drops_backup
			;;
			*)
				echo "ERROR : can't find the docker $2 . Nothing done now"
		esac
	;;
	rm)
		case $2 in 
			pool1)
				docker stop pool1-backup
				docker rm pool1-backup
			;;
			drops)
				docker stop drops-backup
				docker rm drops-backup
			;;
			*)
				echo "ERROR : can't find the docker $2 . Nothing done now"
		esac
	;;
	*)
	
		echo "ERROR : $1 is not an option for pool backup"
	
esac
	
