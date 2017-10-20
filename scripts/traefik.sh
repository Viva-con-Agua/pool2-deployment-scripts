#!/bin/bash

confPath=$"/home/pool/Pool/conf/traefik"

case $1 in
	run)
		docker run --net pool-network -d --name traefik -p 8080:8080 \
		-v ${confPath}/traefik.toml:/etc/traefik/traefik.toml \
		-v ${confPath}/server.toml:/etc/traefik/server.toml \
		-v /var/run/docker.sock:/var/run/docker.sock \
		traefik
	;;
	start)
		docker start traefik
	;;
	stop)
		docker stop traefik
	;;
	rm)
		docker stop traefik
		docker rm traefik
	;;
	logs)
		docker logs traefik
	;;
	*)
		echo $"Usage: §0 {run|start|stop|rm|logs}"
esac
