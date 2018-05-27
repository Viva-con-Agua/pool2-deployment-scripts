pool1='tcp port 80 and host vca.informatik.hu-berlin.de and (((ip[1:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'


pool_dump_docker(){
	docker run --rm --net=container:${1} corfr/tcpdump  -vvvs 0 $2 -l -A -i any;
}


if [ -z "$2" ]; then
	pool_dump_docker $1 ${pool1}
else	
	pool_dump_docker $1 $2
fi
                

