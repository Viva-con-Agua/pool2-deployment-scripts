#path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
scripts=$"${path}"

source ${path}/conf/setup.conf

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

setup_database(){
	# Drops Databases
	bash ${scripts}/drops.sh db run;
        bash ${scripts}/dispenser db run;
        bash ${schript}/bloob db run;
}

setup_control_ms(){
	bash ${scripts}/dispenser.sh run;
        bash ${scripts}/nats.sh run;
}


delete_pool_docker(){
   drops_clean_up;
   dispenser_clean_up;

}
