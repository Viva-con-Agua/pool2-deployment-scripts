#!/bin/bash

##
# configs
##
#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPathNats=$"${path}/conf/nats"

source ${path}/conf/setup.conf



setup_nats_docker(){	
        echo "setup Nats";
	docker run --net pool-network --ip $nats_ip -d --restart=unless-stopped  --name pool-nats nats:${nats_version};
}	



