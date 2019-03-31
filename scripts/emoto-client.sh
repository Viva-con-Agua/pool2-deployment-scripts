#!/bin/bash

emoto_setup_docker(){  
  #Add EMOTO MariaDB
  docker run --name emoto-client-docker --restart=unless-stopped -d vivaconagua/emoto-client:latest;
}

emoto_remove_docker(){
  docker rm -f emoto-client-docker;
}

emoto_logs_docker(){
  docker logs emoto-client-docker;
}

emoto_update_docker(){
  #docker pull vivaconagua/emoto:latest
  docker rm -f emoto-client-docker
  emoto_setup_docker;
}

emoto_release(){
  ./make-release.sh
}


case $1 in
  setup) emoto_setup_docker ;;
  rm) emoto_remove_docker ;;
  log) emoto_logs_docker ;;
  update) emoto_update_docker ;;
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