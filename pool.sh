#!/bin/bash

########################################
#                                      #
# setup script for Pool² Version 0.0.1 #
#                                      #
########################################

path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
scripts=$"${path}"

source ${path}/conf/setup.conf

#include function for deploy docker

source ${path}/scripts/nginx.sh
source ${path}/scripts/bloob.sh
source ${path}/scripts/dispenser.sh
source ${path}/scripts/nats.sh
source ${path}/scripts/sluice.sh
source ${path}/scripts/wordpress.sh
source ${path}/scripts/setup.sh
source ${path}/scripts/drops.sh
source ${path}/scripts/subnet.sh

case $2 in 
   nginx)
      case $1 in
	run)
		if [ -z "$3" ]; then 
			nginx_run_docker $hostname
		else
			nginx_run_docker $3
		fi
		;;
        dev)
               nginx_run_dev_docker
               ;;
	start) 
		docker start nginx-docker
		;;
	stop)
		docker stop nginx-docker
		;;
	rm) 
		docker stop nginx-docker
		docker rm nginx-docker
		;;   
        restart)
               docker stop nginx-docker
               docker rm  nginx-docker
               nginx_run_dev_docker
               ;;
	logs)
		docker logs nginx-docker
		;;
	set-host)
		if [ ! -f ${confPath}/config/ssl.conf ]
		then	
			touch ${confPath}/config/ssl.conf
			echo "ssl_certificate ${3}.pem;" > ${confPath}/config/ssl.conf
			echo "ssl_certificate_key ${3}.key;" >> ${confPath}/config/ssl.conf
		else
			rm ${confPath}/config/ssl.conf	
		 	touch ${confPath}/config/ssl.conf	
			echo "ssl_certificate ${3}.pem;" > ${confPath}/config/ssl.conf     	
		        echo "ssl_certificate_key ${3}.key;" >> ${confPath}/config/ssl.conf
		fi
		;;
	*)
		echo $"Usage: $0 {run|start|stop|rm}"
		exit 1
        esac
        ;;
   dispenser)
      case $1 in

	run)	
		dispenser_run_docker $dispenser_version
	;;
	start)
		docker start dispenser
		;;
	stop) 
		docker stop dispenser
		;;
	rm)	
		dispenser_rm_docker
		;;
	pull)
		dispenser_pull_docker $3
		;;
        init)
                dispenser_set_navigation
                ;;
	db)
		case $3 in 
			run)
				dispenser_setup_database
			;;
			rm)
				dispenser_rm_database
			;;
		*)
			echo "read doku"
		esac
		;;
	*)
		echo $"Usage: $0 {run|start|stop|rm|db}"
      esac
      ;;
   sluice)
      ;;
   drops)
      case $1 in
	run)	
		if [ -z "$3" ]; then 
			drops_setup_dev_docker $drops_version
		else
			drops_setup_dev_docker $3
		fi
		;;
        dev)
               if [ -z "$3" ]; then 
			drops_setup_dev_docker $drops_version
		else
			drops_setup_dev_docker $3
		fi
		;;

	backup)
		drops_db_remove_docker
		;;
	reset)
		drops_remove_docker
		if [ -z "$3" ]; then 
			drops_setup_docker ${VERSION}
		else
			drops_setup_docker $3
		fi
		;;
	start)
		docker start drops
		;;
	stop) 
		docker stop drops
		;;
	rm)
		drops_remove_docker
		;;
	logs)
		docker logs drops
		;;
        pull)
                if [ -z "$3" ]; then
                     drops_pull_docker $drops_version
                else
                     drops_pull_docker $3
                fi
                ;;
	db)
		case $3 in
			run)	
				drops_db_setup_docker
				;;
			start)
				docker start drops-mongo
				docker start drops-mariadb
				;;
			stop) 
				docker stop drops-mongo
				docker stop drops-mariadb
				;;
			rm)
				docker stop drops-mongo
				docker stop drops-mariadb
				docker rm drops-mongo
				docker rm drops-mariadb
				;;
			*)
				echo $"Usage: $0 {run|start|stop|rm}"
		esac
		;;
	*)
		echo $"Usage: $0 {run|start|stop|rm|db}"
   esac
      ;;
   bloob)
      case $1 in 
         run)
            if [ -z "$3" ]; then
               bloob_setup_docker $bloob_version
            else
               bloob_setup_docker $3
            fi
            ;;
         rm)
            docker stop bloob
            docker rm bloob
            ;;
         logs)
            docker logs bloob
            ;;
         db)
            bloob_db_setup
            ;;
         *)
         echo $"Usage: $0 {run|rm|logs}"
      esac
      ;;
   nats)
      case $1 in 
	run)
		setup_nats_docker
	;;
	stop)
		docker stop pool-nats
	;;
	rm)
		docker stop pool-nats
		docker rm pool-nats
	;;
	logs)
		docker logs pool-nats
	;;
	exec)
		docker exec -it pool-oes bash
	;;
	*)
		echo "ERROR"
	;;
      esac
      ;;
   pool)
      case $1 in
	run)
		pool1_setup_docker
		;;
	rm) 
		pool1_rm_docker
		;;
	db)
		case $2 in
			run)
				pool1_setup_db
				;;
			rm)
				pool1_rm_db
				;;
			*)
			echo "Error"
	esac
		;;
	*)
		echo "Error"
      esac
      ;;
   setup)
      case $1 in 
         dev)
            setup_pool_dev
            ;;
         clean)
            delete_pool_docker
         ;;
      *)
         echo "error"
      esac
     ;; 
   *)
      echo "error"
esac
