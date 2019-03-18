#!/bin/bash

#########################
#                       #
# controller for update #
#                       #
#########################

source ${path}/scripts/update.sh

update_usage() {
  echo "run: [-v <arg>]" 1>&2;
  echo "run: [-f <arg>]" 1>&2;
  echo "run: [-d <arg>]" 1>&2; 
  exit;
}
update_controller(){
  case $1 in
    run)
      shift
      while getopts ":vfd" option; do
        case ${option} in
          v) update_versions; exit;;
          f) update_full; exit;;
          d) update_docker; exit;;
       esac
     done
     update_full
     ;;
   *) update_usage
 esac
}
