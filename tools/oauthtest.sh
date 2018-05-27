#!/bin/bash
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/drops"
VERSION=`cat ${confPath}/VERSION`

source ${path}/../pool2.conf
source ${certPath}/password.conf
source ${path}/conf/setup.conf
#!/bin/bash
path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
confPath=$"${path}/../conf/oauthtest"
VERSION=`cat ${confPath}/VERSION`

source ${path}/../pool2.conf
source ${certPath}/password.conf
source ${path}/conf/setup.conf


oauthtest_start_docker(){
	docker create --network pool-network --ip ${oauthtest_ip} --name oauthtest vivaconagua/sample-service:1.0.0-dev \
	-Dplay.http.context="/oauthtest";
	docker cp ${confPath}/drops.conf oauthtest:/opt/docker/conf/drops.conf; 
	docker start oauthtest;
}

case $1 in 
	run)
		oauthtest_start_docker
	;;
	rm)
		docker stop oauthtest
		docker rm oauthtest
	;;
	*)
		echo "run WILL WORK, NOTHING ELSE"
esac
