
insertOautClients(){
echo 'INSERT INTO OauthClient (id, secret, redirectUri, grantTypes) VALUES ("webapps", "dispenser",  "http://localhost/webapps/authenticate/drops","authorization_code")'| mysql -u drops -pdrops -h 172.2.200.2 drops

echo 'INSERT INTO OauthClient (id, secret, redirectUri, grantTypes) VALUES ("dispenser", "dispenser", "http://localhost/dispenser/authenticate/drops", "authorization_code")' | mysql -u drops -pdrops -h 172.2.200.2 drops

echo 'INSERT INTO OauthClient (id, secret, redirectUri, grantTypes) VALUES ("stream", "stream", "http://localhost/stream/authenticate/drops", "authorization_code")' | mysql -u drops -pdrops -h 172.2.200.2 drops
}

