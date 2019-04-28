




stream_backend_setup_docker(){
  docker run --net pool-network --ip $stream_backend_ip --name stream-backend-docker --restart=unless-stopped \
  -d vivaconagua/stream-backend:${stream_backend_version} \
   -Dnats.endpoint="nats://172.2.100.2:4222" \
   -Dms.name="WEBAPPS" \
   -Dms.host="https://${hostname}/webapps" \
   -Dms.entrypoint="/authenticate/drops" \
   -Ddrops.url.base="https://${hostname}/drops" \
   -Ddrops.client_id="webapps" \
   -Ddrops.client_secret=$drops_secret \
   -Dplay.http.context="/webapps" ;

}

stream_backend_remove_docker(){
  docker rm -f stream-backend-docker;
}


stream_backend_update_docker(){
   docker pull vivaconagua/stream-backend:${stream_backend_version};
   docker rm -f stream-backend-docker;
   stream_backend_setup_docker;
}

stream_backend_logs_docker(){
  docker logs stream-backend-docker;
}
