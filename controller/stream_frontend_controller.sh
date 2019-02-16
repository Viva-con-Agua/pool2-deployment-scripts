#!/bin/bash

##################################
#                                #
# controller for stream-frontend #
#                                #
##################################
#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
source ${path}/scripts/stream-frontend.sh

stream_frontend_usage() {
  echo "run: [-v <arg>]" 1>&2;
  echo "run: [-p <arg>]" 1>&2;
  echo "run: [-d <arg>]" 1>&2; 
  exit;
}

stream_frontend_controller(){
  case $1 in 
    run)
      shift
      while getopts ":dpv" option; do
        case ${option} in
          v) stream_frontend_version=${OPTARG};;
          d) stream_frontend_setup_docker
             exit 1;;
          p) stream_frontend_setup_docker
             exit 1;;
        esac
      done
      stream_frontend_setup_docker
    ;;
   update) stream_frontend_update_docker;;
   stop) docker stop stream-frontend;;
   rm ) docker rm -f stream-frontend;;
   logs) docker logs stream-frontend;;
   exec) docker exec -it stream-frontend bash ;;
   *) stream_frontend_usage
  esac
}
