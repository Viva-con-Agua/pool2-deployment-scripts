#!/bin/bash

ripple_setup_docker(){
  docker run --net pool-network --ip $ripple_ip --name ripple --restart=unless-stopped -d vivaconagua/ripple-docker;
}
