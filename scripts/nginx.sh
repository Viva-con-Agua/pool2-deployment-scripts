#!/bin/bash
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/nginx"
certPath=$"/home/pool/Pool/cert"
source ${path}/../pool2.conf

nginx_run_docker(){
	docker run --net pool-network --ip 172.2.0.2 --name nginx-docker --restart=unless-stopped -p 443:443 -p 80:80 \
		-v ${confPath}/config:/etc/nginx/conf.d/ \
		-v ${confPath}/config/test.html:/var/www/html/test \
		-v ${certPath}/${1}.chained.pem:/etc/nginx/${1}.pem \
		-v ${certPath}/${1}.key:/etc/nginx/${1}.key \
		-v ${certPath}/ticket.key:/etc/nginx/ticket.key \
		-v ${certPath}/global.pass:/etc/nginx/global.pass \
		-d nginx:1.12.1 'nginx-debug' '-g' 'daemon off;';
		#-v ${confPath}/nginx.conf:/etc/nginx/nginx.conf \
	#	-d nginx:1.13.7 

}


case $1 in
	run)
		if [ -z "$2" ]; then 
			nginx_run_docker $hostname
		else
			nginx_run_docker $2
		fi
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
        restart)
               docker stop nginx-docker
               docker rm  nginx-docker
               nginx_run_docker $hostname
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
	
	
