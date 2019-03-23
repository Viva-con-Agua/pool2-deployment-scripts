#!/bin/bash

########################
#                      #
# controller for waves_frontend #
#                      #
########################
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
          d) waves_frontend_run
             exit 1;;
          p) waves_frontend_run
             exit 1;;
        esac
      done
      waves_frontend_run
    ;;
   update) waves_frontend_update;;
   stop) docker stop waves.frontend;;
   rm ) waves_frontend_remove;;
   logs) waves_frontend_logs;;
   exec) docker exec -it arise-docker bash ;;
   *) waves_frontend_usage
  esac
}
