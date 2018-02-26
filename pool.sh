#!/bin/bash

path=$(cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
docker=$"${path}/scripts/"

case $2 in
	nginx)
		bash ${docker}nginx.sh $1 $3
	;;
	traefik)
		bash ${docker}traefik.sh $1
	;;
	drops)
		bash ${docker}drops.sh $1 $3
	;;
	dispenser)
		bash ${docker}dispenser.sh $1 $3
	;;
	sluice)
		bash ${docker}sluice.sh $1 $3
	;; 
	mail)
		bash ${docker}mailserver.sh $1 $3
	;; 
	pool1)
		bash ${docker}wordpress.sh $1 $3
	;;
	oes)
		bash ${docker}oes.sh $1 $3
	;;
	list)
		echo $"nginx" 
	;;
	dump)
		bash ${docker}tcpdump.sh $1 $3
	;;
	backup)
		bash ${docker}backup.sh $1 $3 $4
	;;
	network)
		case $1 in
			show)
				docker network inspect pool-network
			;;
			*)
				echo $"Usage: $0 {show}"
				exit 1
		esac
	;;
 	*)
		echo $"Usage: $0 {list-docker|DOCKER}"
		exit 1 
esac
