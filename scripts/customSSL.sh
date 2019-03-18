#!/bin/bash

create_new_rootkey(){
  openssl genrsa -des3 -out ${1}.key 2048;
}

create_new_ca(){
  openssl req -x509 -new -nodes -key ${domain}.key -sha256 -days 1024 -out ${domain}.pem;
}


