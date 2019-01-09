#!/bin/bash

source ${path}/scripts/backup.sh

backup_controller(){
case $1 in
	run)
		setup_pool1_backup;
		setup_drops_backup;
		;;
esac
}
		
