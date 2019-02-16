#!/bin/bash

stream_frontend_setup_docker(){
  docker run --net pool-network --ip $stream_frontend_ip --name stream-frontend --restart=unless-stopped -d vivaconagua/stream-frontend:${stream_frontend_version};
}

stream_frontend_remove_docker(){
  docker rm -f stream-frontend;
}

stream_frontend_logs_docker(){
  docker logs stream-frontend;
}

stream_frontend_update_docker(){
  docker pull vivaconagua/stream-frontend:${stream_frontend_version};
  docker rm -f stream-frontend;
  stream_frontend_setup_docker;
}
