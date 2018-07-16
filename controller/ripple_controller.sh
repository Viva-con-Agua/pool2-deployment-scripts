#!/bin/bash

########################
#                      #
# controller for drops #
#                      #
########################
#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
source ${path}/scripts/ripple.sh

ripple_usage() {
  echo "run: [-v <arg>]" 1>&2;
  echo "run: [-p <arg>]" 1>&2;
  echo "run: [-d <arg>]" 1>&2; 
  exit;
}

ripple_controller(){
  case $1 in 
    run)
      shift
      while getopts ":dpv" option; do
        case ${option} in
          v) ripple_version=${OPTARG};;
          d) ripple_setup_docker
             exit 1;;
          p) ripple_setup_docker
             exit 1;;
        esac
      done
      ripple_setup_docker
    ;;
   stop) docker stop ripple-docker;;
   rm ) docker rm -f ripple-docker;;
   logs) docker logs ripple-docker;;
   exec) docker exec -it ripple-docker bash ;;
   *) ripple_usage
  esac
}
