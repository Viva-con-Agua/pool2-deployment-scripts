

stream_backend_setup_docker(){
  docker run --net pool-network --ip $stream_backend_ip --name stream-backend-docker --restart=unless-stopped \
  -d vivaconagua/stream-backend:${stream_backend_version} \
   -Dnats.endpoint="nats://172.2.100.2:4222" \
   -Dms.name="STREAM" \
   -Dms.host="https://${hostname}/backend/stream" \
   -Dms.entrypoint="/authenticate/drops" \
   -Ddrops.url.base="https://${hostname}/drops" \
   -Ddrops.client_id="stream" \
   -Ddrops.client_secret=$stream_backend_secret \
   -Dplay.http.context="/backend/stream" ;

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

#database for steam

stream_database_setup_docker(){
  echo "setup Stream-Database";
  docker run --net pool-network --ip $stream_db_maria_ip --name stream-database --restart=unless-stopped \
    -e MYSQL_ROOT_PASSWORD=stream \
	    	-e MYSQL_DATABASE=stream \
    		-e MYSQL_USER=stream\
    		-e MYSQL_PASSWORD=stream \
    		-e MYSQL_ROOT_PASSWORD=yes \
    		-d mariadb:latest;
}
stream_database_backup_docker(){
  docker run --net pool-network -v ${path}/../backup/stream-database:/db --env-file ${confPath}/stream-database.env deitch/mysql-backup
}

stream_database_remove_docker(){
  echo "backup database data"
  stream_database_backup_docker
  echo "remove stream-database"
  docker rm -f stream-database
}

