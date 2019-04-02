#!/bin/bash

########################
#                      #
# controller for emoto #
#                      #
########################
#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
source ${path}/scripts/emoto.sh
source ${path}/scripts/emoto-client.sh
emoto_backen_usage(){
echo "Usage: ./emoto.sh db COMMAND"
        echo ""
        echo "Comands:"
        echo "  setup    setup a local docker container for emoto database"
        echo "  rm       remove the docker container emoto database"
        echo "  log      print emoto database log"
        echo "  update   update the emoto database docker container to the latest verion"

  }

emoto_backend_controller(){
  case $1 in
  setup)
    shift
    while getopts ":D" option; do
      case ${option} in
        D) emoto_db_setup_docker; exit 1;;
      esac
    done
    emoto_setup_docker 
   ;;
  rm) emoto_remove_docker ;;
  log) emoto_logs_docker ;;
  update) emoto_update_docker ;;
  db) case $2 in 
      setup) emoto_db_setup_docker ;;
      rm) emoto_db_remove_docker ;;
      log) emoto_db_logs_docker ;;
      update) emoto_db_update_docker ;;
      *)
        echo "Usage: ./emoto.sh db COMMAND"
        echo ""
        echo "Comands:"
        echo "  setup    setup a local docker container for emoto database"
        echo "  rm       remove the docker container emoto database"
        echo "  log      print emoto database log"
        echo "  update   update the emoto database docker container to the latest verion"
    esac;;
  *) 
    #ToDo: Add db commands
    echo "Usage: ./emoto.sh COMMAND"
    echo ""
    echo "Commands:"
    echo "  setup    setup a local docker container for emoto"
    echo "  rm       remove the docker container emoto and emoto-db"
    echo "  log      print emoto log"
    echo "  update   update the emoto docker container to the latest verion"
    echo "  release  make a release of the current emoto state"
esac
}

emoto_frontend_controller(){
case $1 in
  setup) emoto_setup_frontend_docker ;;
  rm) emoto_remove_frontend_docker ;;
  log) emoto_logs_frontend_docker ;;
  update) emoto_update_frontend_docker ;;
  *) 
    echo "Usage: ./emoto-client.sh COMMAND"
    echo ""
    echo "Commands:"
    echo "  setup    setup a local docker container for emoto-client"
    echo "  rm       remove the docker container emoto-client"
    echo "  log      print emoto-client log"
    echo "  update   update the emoto-client docker container to the latest verion"
    echo "  release  make a release of the current emoto-client state"
esac
  
}

