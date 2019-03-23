#!/bin/bash

waves_frontend_run(){
  docker run --net pool-network --ip $waves_frontend_ip --name waves-frontend --restart=unless-stopped -d vivaconagua/waves-frontend:${waves_frontend_version};
}

waves_frontend_remove(){
  docker rm -f waves-frontend;
}

waves_frontend_logs(){
  docker logs waves-frontend;
}

waves_frontend_update(){
  docker pull vivaconagua/waves-frontend:${waves_frontend_version};
  docker rm -f waves-frontend;
  waves_frontend_run;
}
