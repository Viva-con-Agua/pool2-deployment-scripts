#!/bin/bash

########################
#                      #
# controller for arise #
#                      #
########################
#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
source ${path}/scripts/webapps.sh

webapps_usage() {
  echo "run: [-v <arg>]" 1>&2;
  echo "run: [-p <arg>]" 1>&2;
  echo "run: [-d <arg>]" 1>&2;
  exit;
}

webapps_controller(){
  case $1 in
    run)
      shift
      while getopts ":dpv" option; do
        case ${option} in
          v) webapps_version=${OPTARG};;
          d) webapps_setup_docker
             exit 1;;
          p) webapps_setup_docker
             exit 1;;
        esac
      done
      webapps_setup_docker
    ;;
   stop) docker stop webapps-docker;;
   rm ) docker rm -f webapps-docker;;
   logs) docker logs webapps-docker;;
   exec) docker exec -it webapps-docker bash ;;
   *) webapps_usage
  esac
}
