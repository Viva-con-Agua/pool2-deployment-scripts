#!/bin/bash

emoto_setup_frontend_docker(){  
  #Add EMOTO MariaDB
  docker run --net pool-network --ip $emoto_frontend_ip --name emoto-client-docker --restart=unless-stopped -d vivaconagua/emoto-client:$emoto_version;
}

emoto_remove_frontend_docker(){
  docker rm -f emoto-client-docker;
}

emoto_logs_frontend_docker(){
  docker logs emoto-client-docker;
}

emoto_update_frontend_docker(){
  docker pull vivaconagua/emoto-client:$emoto_version;
  docker rm -f emoto-client-docker
  emoto_setup_frontend_docker;
}

emoto_release(){
  ./make-release.sh
}


#case $1 in
#  setup) emoto_setup_frontend_docker ;;
#  rm) emoto_remove_frontend_docker ;;
#  log) emoto_logs_frontend_docker ;;
#  update) emoto_update_frontend_docker ;;
#  *) 
#    echo "Usage: ./emoto-client.sh COMMAND"
#    echo ""
#    echo "Commands:"
#    echo "  setup    setup a local docker container for emoto-client"
#    echo "  rm       remove the docker container emoto-client"
#    echo "  log      print emoto-client log"
#    echo "  update   update the emoto-client docker container to the latest verion"
#    echo "  release  make a release of the current emoto-client state"
#esac
