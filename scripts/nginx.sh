#!/bin/bash
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/nginx"
certPath=$"/home/pool/Pool/cert"
case $1 in
	run)

		docker run --net pool-network --ip 172.2.0.2 --name nginx-docker -p 443:443 -p 80:80 \
		-v ${confPath}/config:/etc/nginx/conf.d/ \
		-v ${confPath}/config/test.html:/var/www/html/test \
		-v ${certPath}/nopw/${2}.pem:/etc/nginx/${2}.pem \
		-v ${certPath}/nopw/${2}.key:/etc/nginx/${2}.key \
		-v ${certPath}/global.pass:/etc/nginx/global.pass \
		-d nginx:1.12.1 'nginx-debug' '-g' 'daemon off;'
		;;
	start) 
		docker start nginx-docker
		;;
	stop)
		docker stop nginx-docker
		;;
	rm)
		docker stop nginx-docker
		docker rm nginx-docker
		;;
	logs)
		docker logs nginx-docker
		;;
	set-host)
		if [ ! -f ${confPath}/config/ssl.conf ]
		then	
			touch ${confPath}/config/ssl.conf
			echo "ssl_certificate ${2}.pem;" > ${confPath}/config/ssl.conf
			echo "ssl_certificate_key ${2}.key;" >> ${confPath}/config/ssl.conf
		else
			rm ${confPath}/config/ssl.conf	
		 	touch ${confPath}/config/ssl.conf	
			echo "ssl_certificate ${2}.pem;" > ${confPath}/config/ssl.conf     	
		        echo "ssl_certificate_key ${2}.key;" >> ${confPath}/config/ssl.conf
		fi
		;;
	*)
		echo $"Usage: $0 {run|start|stop|rm}"
		exit 1
esac
	
	
