#!/bin/bash

########################################
#                                      #
# setup script for Pool² Version 0.2.1 #
#                                      #
########################################

path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
scripts=$"${path}"

source ${path}/conf/setup.conf
source ${path}/conf/version.conf

#include function for deploy docker

source ${path}/controller/nginx_controller.sh
source ${path}/controller/bloob_controller.sh
source ${path}/controller/dispenser_controller.sh
source ${path}/controller/nats_controller.sh
source ${path}/scripts/sluice.sh
source ${path}/scripts/wordpress.sh
source ${path}/controller/setup_controller.sh
source ${path}/controller/drops_controller.sh
source ${path}/controller/ripple_controller.sh
source ${path}/controller/subnet_controller.sh
source ${path}/controller/arise_controller.sh
source ${path}/controller/webapps_controller.sh
source ${path}/controller/backup_controller.sh

source ${path}/controller/stream_frontend_controller.sh
source ${path}/controller/stream_backend_controller.sh
source ${path}/controller/update_controller.sh
source ${path}/controller/waves_frontend_controller.sh
source ${path}/controller/emoto_controller.sh

source ${path}/controller/upsweep_backend_controller.sh

case ${@: -1} in
  webapps) webapps_controller $@;;
  drops) drops_controller $@;;
  ripple) ripple_controller $@;;
  nginx) nginx_controller $@;;
  dispenser) dispenser_controller $@;;
  bloob) bloob_controller $@;;
  setup) setup_controller $@;;
  subnet) subnet_controller $@;;
  nats) nats_controller $@;;
  arise) arise_controller $@;;
  backup) backup_controller $@;;
  pool) pool1_controller $@;;
  stream-frontend) stream_frontend_controller $@;;
  stream-backend) stream_backend_controller $@;;
  update) update_controller $@;;
  waves-frontend) waves_frontend_controller $@;;
  emoto) emoto_backend_controller $@;;
  emoto-frontend) emoto_frontend_controller $@;;
  upsweep-backend) upsweep_backend_controller $@;;

  *) echo "microservice not supported"

esac
