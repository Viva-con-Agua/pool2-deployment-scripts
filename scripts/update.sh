


update_versions(){
  echo "Update version.conf"
  echo "Backup old version.conf ..."
  mv ${path}/conf/version.conf ${path}/conf/version.conf.bak
  echo "Backup done"
  echo "update version.conf ..."
  wget -P ${path}/conf/ https://raw.githubusercontent.com/Viva-con-Agua/pool-version/${pool_version}/version.conf
  if [ -e ${path}/conf/version.conf ]
  then
    source ${path}/conf/version.conf
    echo "Update version.conf successful" 
  else 
    mv ${path}/conf/version.conf.bak ${path}/conf/version.conf
    echo "Something wrong. Restore last version.conf"
  fi
}

update_docker(){
  arise_update;
  drops_update_docker;
  dispenser_update;
  webapp_update; 
  waves_frontend_update;
}

update_full(){
  update_versions;
  update_docker;
}
