#!/bin/bash
#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPathNginx=$"${path}/conf/nginx"
certPathNginx=$"/home/pool/Pool/cert"
source ${path}/pool2.conf
source ${path}/conf/setup.conf





nginx_run_docker(){
         echo "setup Nginx"
	docker run --net pool-network --ip $nginx_ip --name nginx-docker --restart=unless-stopped -p 443:443 -p 80:80 \
		-v ${confPathNginx}/default.conf:/etc/nginx/conf.d/default.conf \
                -v ${confPathNginx}/pool2.location:/etc/nginx/conf.d/pool2.location \
                -v ${confPathNginx}/pool2.upstream:/etc/nginx/conf.d/pool2.upstream \
		-v ${certPathNginx}/wildcard.vivaconagua.org.chained.crt:/etc/nginx/wildcard.vivaconagua.org.chained.crt \
		-v ${certPathNginx}/wildcard.vivaconagua.org.key:/etc/nginx/wildcard.vivaconagua.org.key \
		-v ${certPathNginx}/ticket.key:/etc/nginx/ticket.key \
		-d nginx:1.13.7;

}
nginx_run_dev_docker(){
         echo "setup Nginx in dev mode"
      docker run --net host --name nginx-docker --restart=unless-stopped -p 80:80 \
               -v ${confPathNginx}/config/default_dev.conf:/etc/nginx/conf.d/default.conf \
               -v ${confPathNginx}/config/pool2.location:/etc/nginx/conf.d/pool2.location \
               -v ${confPathNginx}/config/pool2.upstream:/etc/nginx/conf.d/pool2.upstream \
               -d nginx:1.12.1 'nginx-debug' '-g' 'daemon off;';
}

	
	
