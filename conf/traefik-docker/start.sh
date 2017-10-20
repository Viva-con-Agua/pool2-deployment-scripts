docker run --net poolNet -d --name traefik -p 8080:8080 \
-v $PWD/traefik.toml:/etc/traefik/traefik.toml \
-v $PWD/server.toml:/etc/traefik/server.toml \
-v /var/run/docker.sock:/var/run/docker.sock \
traefik
