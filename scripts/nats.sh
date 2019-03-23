#!/bin/bash

##
# configs
##
#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPathNats=$"${path}/conf/nats"

source ${path}/pool2.conf
source ${certPath}/password.conf
source ${path}/conf/setup.conf



setup_nats_docker(){	
        echo "setup Nats";
	docker run --net pool-network --ip $nats_ip -d --restart=unless-stopped -p 5000:6222 --name pool-nats nats:${nats_version};
}	



