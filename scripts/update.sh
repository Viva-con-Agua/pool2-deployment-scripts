


update_versions(){
  rm ${path}/conf/version.conf;
wget -P ${path}/conf/ https://raw.githubusercontent.com/Viva-con-Agua/pool-version/${pool_version}/version.conf 
}

update_docker(){
  arise_update;
  drops_update_docker;
  dispenser_update;
  webapp_update; 
}

update_full(){
  update_versions;
  update_docker;
}
