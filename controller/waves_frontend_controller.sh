#!/bin/bash

#################################
#                               #
# controller for waves_frontend #
#                               #
#################################
#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
source ${path}/scripts/waves-frontend.sh

waves_frontend_usage() {
  echo "run: [-v <arg>]" 1>&2;
  echo "run: [-p <arg>]" 1>&2;
  echo "run: [-d <arg>]" 1>&2; 
  exit;
}

waves_frontend_controller(){
  case $1 in 
    run)
      shift
      while getopts ":dpv" option; do
        case ${option} in
          v) waves_frontend_version=${OPTARG};;
          d) waves_frontend_setup_docker
             exit 1;;
          p) waves_frontend_setup_docker
             exit 1;;
        esac
      done
      waves_frontend_setup_docker
    ;;
   update) waves_frontend_update_docker;;
   stop) docker stop waves-frontend-docker;;
   rm ) docker rm -f waves-frontend-docker;;
   logs) docker logs waves-frontend-docker;;
   exec) docker exec -it waves-frontend-docker bash ;;
   *) waves_frontend_usage
  esac
}
