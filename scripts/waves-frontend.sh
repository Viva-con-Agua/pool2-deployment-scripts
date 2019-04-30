#!/bin/bash

waves_frontend_setup_docker(){
  docker run --net pool-network --ip $waves_frontend_ip --name waves-frontend-docker --restart=unless-stopped -d vivaconagua/waves-frontend:${waves_frontend_version};
}

waves_frontend_remove_docker(){
  docker rm -f waves-frontend-docker;
}

waves_frontend_logs_docker(){
  docker logs waves-frontend-docker;
}

waves_frontend_update_docker(){
  docker pull vivaconagua/waves-frontend:${waves_frontend_version};
  docker rm -f waves-frontend-docker;
  waves_frontend_setup_docker;
}
