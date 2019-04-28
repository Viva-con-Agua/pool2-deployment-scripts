#!/bin/bash

##################################
#                                #
# controller for stream-backend  #
#                                #
##################################
#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
source ${path}/scripts/stream-backend.sh

stream_backend_usage() {
  echo "run: [-v <arg>]" 1>&2;
  echo "run: [-p <arg>]" 1>&2;
  echo "run: [-d <arg>]" 1>&2; 
  exit;
}

stream_backend_controller(){
  case $1 in 
    run)
      shift
      while getopts ":dpv" option; do
        case ${option} in
          v) stream_backend_version=${OPTARG};;
          d) stream_backend_setup_docker
             exit 1;;
          p) stream_backend_setup_docker
             exit 1;;
        esac
      done
      stream_backend_setup_docker
    ;;
   update) stream_backend_update_docker;;
   stop) docker stop stream-backend-docker;;
   rm ) docker rm -f stream-backend-docker;;
   logs) docker logs stream-backend-docker;;
   exec) docker exec -it stream-backend-docker bash ;;
   *) stream_backend_usage
  esac
}
