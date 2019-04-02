#!/bin/bash

arise_run(){
  docker run --net pool-network --ip $arise_ip --name arise-docker --restart=unless-stopped -d vivaconagua/arise:${arise_version};
}

arise_restart(){
  arise_remove;
  arise_run;
}
arise_remove(){
  docker rm -f arise-docker;
}

arise_logs(){
  docker logs arise-docker;
}

arise_update(){
  docker pull vivaconagua/arise:${arise_version};
  docker rm -f arise-docker;
  arise_run;
}
