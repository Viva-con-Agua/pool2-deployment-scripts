#!/bin/bash

path=$"/home/pool/Pool/scripts/"
docker=$"${path}docker/"

case $1 in
	nginx)
		bash ${docker}nginx.sh $2
	;;
	traefik)
		bash ${docker}traefik.sh $2
	;;
	drops)
		bash ${docker}drops.sh $2 $3
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
