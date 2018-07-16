

subnet_controller(){
  case $1 in
    run) pool_create_subnet;;
    rm) pool_remove_subnet;;
  esac
}
