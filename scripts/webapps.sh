webapps_setup_docker(){
  docker run --net pool-network --ip $webapps_ip --name webapps-docker --restart=unless-stopped \
  -d vivaconagua/webapps-drops-oauth:${webapps_version} \
   -Dnats.endpoint="nats://172.2.100.2:4222" \
   -Dms.name="WEBAPPS" \
   -Dms.host="http://localhost/webapps" \
   -Dms.entrypoint="/authenticate/drops" \
   -Ddrops.url.base="http://localhost/drops" \
   -Ddrops.client_id="webapps" \
   -Ddrops.client_secret="webapps" \
   -Dplay.http.context="/webapps" ;

}

webapps_remove_docker(){
  docker rm -f webapps-docker;
}

webapps_logs_docker(){
  docker logs webapps-docker;
}
