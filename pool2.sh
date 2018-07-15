#!/bin/bash

########################################
#                                      #
# setup script for Pool² Version 0.1.1 #
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


