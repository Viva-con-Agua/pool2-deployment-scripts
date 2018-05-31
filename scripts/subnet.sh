#!/bin/bash

pool_create_subnet(){
   docker network create -d bridge --subnet 172.2.0.0/16 pool-network;
}

pool_network_remove(){
   docker network rm pool-network;
}
