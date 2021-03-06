#!/bin/bash

########################
#                      #
# controller for arise #
#                      #
########################
#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
source ${path}/scripts/arise.sh

arise_usage() {
  echo "run: [-v <arg>]" 1>&2;
  echo "run: [-p <arg>]" 1>&2;
  echo "run: [-d <arg>]" 1>&2; 
  exit;
}

arise_controller(){
  case $1 in 
    run)
      shift
      while getopts ":dpv" option; do
        case ${option} in
          v) arise_version=${OPTARG};;
          d) arise_run
             exit 1;;
          p) arise_run
             exit 1;;
        esac
      done
      arise_run
    ;;
   update) arise_update;;
   stop) docker stop arise-docker;;
   restart) arise_restart;;
   rm ) arise_remove;;
   logs) arise_logs;;
   exec) docker exec -it arise-docker bash ;;
   *) arise_usage
  esac
}
