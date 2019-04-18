#!/bin/bash

emoto_setup_docker(){  
  #Add EMOTO MariaDB
  docker run --net pool-network --ip $emoto_backend_ip --name emoto-docker --restart=unless-stopped -d  \
    -e NODE_ENV="production" \
    -e EMOTO_CIVI_SITE_KEY=${civi_site_key} \
    -e EMOTO_CIVI_USER_KEY=${civi_user_key} \
    vivaconagua/emoto:$emoto_version;

}

emoto_remove_docker(){
  docker rm -f emoto-docker;
}

emoto_logs_docker(){
  docker logs emoto-docker;
}

emoto_update_docker(){
  docker pull vivaconagua/emoto:$emoto_version;
  docker rm -f emoto-docker;
  emoto_setup_docker;
}

emoto_release(){
  ./make-release.sh
}

## ToDo: Add DB Scripts
emoto_db_setup_docker (){
   	docker run --net pool-network --ip $emoto_db_ip --name emoto-mariadb --restart=unless-stopped \
		-e MYSQL_ROOT_PASSWORD=emoto \
	    	-e MYSQL_DATABASE=emoto \
    		-e MYSQL_USER=emoto \
    		-e MYSQL_PASSWORD=emoto \
    		-e MYSQL_ROOT_PASSWORD=yes \
    		-d mariadb:latest;


}

emoto_db_remove_docker (){
  echo "not implemented"
}

emoto_db_logs_docker (){
  echo "not implemented"
}

emoto_db_update_docker (){
  echo "not implemented"
}

#case $1 in
#  setup) emoto_setup_docker ;;
#  rm) emoto_remove_docker ;;
#  log) emoto_logs_docker ;;
#  update) emoto_update_docker ;;
#  db) case $2 in 
#      setup) emoto_db_setup_docker ;;
#      rm) emoto_db_remove_docker ;;
#      log) emoto_db_logs_docker ;;
#      update) emoto_db_update_docker ;;
#      *)
#        echo "Usage: ./emoto.sh db COMMAND"
#        echo ""
#        echo "Comands:"
#        echo "  setup    setup a local docker container for emoto database"
#        echo "  rm       remove the docker container emoto database"
#        echo "  log      print emoto database log"
#        echo "  update   update the emoto database docker container to the latest verion"
#    esac;;
#  *) 
#    #ToDo: Add db commands
#    echo "Usage: ./emoto.sh COMMAND"
#    echo ""
#    echo "Commands:"
#    echo "  setup    setup a local docker container for emoto"
#    echo "  rm       remove the docker container emoto and emoto-db"
#    echo "  log      print emoto log"
#    echo "  update   update the emoto docker container to the latest verion"
#    echo "  release  make a release of the current emoto state"
#esac
