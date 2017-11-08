#!/bin/bash

path=$(cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
docker=$"${path}/scripts/"

case $1 in
	nginx)
		bash ${docker}nginx.sh $2 $3
	;;
	traefik)
		bash ${docker}traefik.sh $2
	;;
	drops)
		bash ${docker}drops.sh $2 $3
	;;
	dispenser)
		bash ${docker}dispenser.sh $2 $3
	;;
	sluice)
		bash ${docker}sluice.sh $2 $3
	;; 
	mail)
		bash ${docker}mailserver.sh $2 $3
	;; 
	list)
		echo $"nginx" 
	;;
	network)
		case $2 in
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
