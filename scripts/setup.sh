#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
scripts=$"${path}"

source ${path}/conf/setup.conf
source ${path}/scripts/subnet.sh

setup_folder(){
  #create cert folder

  if [ ! -d "${path}/../cert" ]; then
      mkdir ${path}/../cert
      echo "setup cert folder"
  else
     echo "use existing cert folder"
  fi

  #copy password.conf
  
  if [ ! -f ${path}/../cert/password.conf ]; then
       cp ${path}/password.conf ${path}/../cert/password.conf
       echo "File not found!"
  fi
}

insertOautClients(){
echo 'INSERT INTO OauthClient (id, secret, redirectUri, grantTypes) VALUES ("webapps", "dispenser",  "http://localhost/webapps/authenticate/drops","authorization_code")'| mysql -u drops -pdrops -h 172.2.200.2 drops

echo 'INSERT INTO OauthClient (id, secret, redirectUri, grantTypes) VALUES ("dispenser", "dispenser", "http://localhost/dispenser/authenticate/drops", "authorization_code")' | mysql -u drops -pdrops -h 172.2.200.2 drops

echo 'INSERT INTO OauthClient (id, secret, redirectUri, grantTypes) VALUES ("stream", "stream", "http://localhost/stream/authenticate/drops", "authorization_code")' | mysql -u drops -pdrops -h 172.2.200.2 drops
}


setup_database(){
	# Drops Databases
        drops_db_setup_docker;
        dispenser_setup_database_docker;        
}

setup_dev_ms(){
      dispenser_run;
      setup_nats_docker;
      drops_setup_dev_docker;
      arise_run;
      webapps_setup_docker;
      nginx_run_dev_docker;
      dispenser_set_navigation;
}

setup_pool_dev(){
      setup_folder;
      pool_create_subnet;
      setup_database;
      setup_dev_ms;
      insertOautClients;
}

setup_control_ms(){
      setup_folder;
      dispenser_run;
      sleep 15;
      setup_nats_docker;
      drops_setup_docker;
}

delete_pool_docker(){
   docker stop drops;
   docker rm drops;
   docker rm -f arise-docker;
   docker rm -f webapps-docker;
   docker stop dispenser;
   docker rm dispenser;
   docker stop pool-nats;
   docker rm pool-nats;
   docker stop nginx-docker;
   docker rm nginx-docker;
   docker rm -f webapps-docker;

}

delete_pool_docker_full(){

   drops_clean_up;
   dispenser_clean;
   docker rm -f arise-docker;
   docker stop pool-nats;
   docker rm pool-nats;
   docker stop nginx-docker;
   docker rm nginx-docker;
   pool_remove_subnet;

}
