confPathUpsweep=$"${path}/conf/upsweep"

upsweep_setup_database_docker(){
  docker run --net pool-network --ip $upsweep_database_ip --name upseep-database --restart=unless-stopped -d mongo;
}
