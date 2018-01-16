docker commit -p pool1 pool1-docker
docker tag pool1-docker vivaconagua/pool1-docker
docker push vivaconagua/pool1-docker
docker commit -p pool1-mysql pool1-mysql-docker
docker tag pool1-mysql-docker vivaconagua/pool1-mysql-docker
docker push vivaconagua/pool1-mysql-docker
