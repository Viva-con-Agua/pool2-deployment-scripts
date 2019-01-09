#!/bin/bash

arise_setup_docker(){
  docker run --net pool-network --ip $arise_ip --name arise-docker --restart=unless-stopped -d vivaconagua/arise:${arise_version};
}

arise_remove_docker(){
  docker rm -f arise-docker;
}

arise_logs_docker(){
  docker logs arise-docker;
}

arise_update_docker(){
  docker pull vivaconagua/arise:${arise_version};
  docker rm -f arise-docker;
  arise_setup_docker;
}
