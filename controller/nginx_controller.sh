#!/bin/bash

########################
#                      #
# controller for nginx #
#                      #
########################

source ${path}/scripts/nginx.sh

nginx_controller(){
  case $1 in
      run)
        shift
        while getopts ":dph" option; do
          case ${options} in
            h) hostname=${OPTARG};;
            d) nginx_run_dev_docker;;
            p) nginx_run_docker;;
          esac
        done
        nginx_run_dev_docker
      ;;
      start) docker start nginx-docker;;
      stop) docker stop nginx-docker;;
      rm) docker rm -f nginx-docker;;   
      restart) docker rm -f nginx-docker; nginx_run_dev_docker;;
      logs) docker logs nginx-docker;;
      *)
          echo $"Usage: $0 {run|start|stop|rm}"
          exit 1
      esac
}
