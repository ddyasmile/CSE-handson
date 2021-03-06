docker network create \
    --subnet=172.18.0.0/16 \
    --gateway=172.18.0.1 \
    handson3net

docker run  \
    --name frontend \
    --network handson3net \
    --ip 172.18.0.2 \
    --add-host shipping:172.18.0.3 \
    --add-host user:172.18.0.4 \
    --add-host orders:172.18.0.5 \
    --add-host carts:172.18.0.6 \
    --add-host payment:172.18.0.7 \
    --add-host catalogue:172.18.0.8 \
    --add-host session-db:172.18.0.13 \
    -e SESSION_REDIS=true \
    -d dplsming/sockshop-frontend:0.1

docker run  \
    --name shipping \
    --network handson3net \
    --ip 172.18.0.3 \
    -d weaveworksdemos/shipping:0.4.8

docker run  \
    --name user \
    --network handson3net \
    --ip 172.18.0.4 \
    --add-host user-db:172.18.0.9 \
    -e MONGO_HOST=user-db:27017 \
    -d weaveworksdemos/user:0.4.4

docker run  \
    --name orders \
    --network handson3net \
    --ip 172.18.0.5 \
    --add-host shipping:172.18.0.3 \
    --add-host user:172.18.0.4 \
    --add-host carts:172.18.0.6 \
    --add-host payment:172.18.0.7 \
    --add-host orders-db:172.18.0.9 \
    -d weaveworksdemos/orders:0.4.7

docker run  \
    --name carts \
    --network handson3net \
    --ip 172.18.0.6 \
    --add-host carts-db:172.18.0.9 \
    -d weaveworksdemos/carts:0.4.8

docker run  \
    --name payment \
    --network handson3net \
    --ip 172.18.0.7 \
    -d weaveworksdemos/payment:0.4.3

docker run  \
    --name catalogue \
    --network handson3net \
    --ip 172.18.0.8 \
    --add-host catalogue-db:172.18.0.10 \
    -d weaveworksdemos/catalogue:0.3.5

docker run  \
    --name mongo-db \
    --network handson3net \
    --ip 172.18.0.9 \
    -d mongo:3.4

docker run  \
    --name catalogue-db \
    --network handson3net \
    --ip 172.18.0.10 \
    -d dplsming/sockshop-cataloguedb:0.1

docker run  \
    --name nginx-static \
    --network handson3net \
    --ip 172.18.0.11 \
    -v /home/ddya/cse-tot/reading/handson3/thirdstep/nginxstatic:/etc/nginx/conf.d \
    -v /home/ddya/cse-tot/reading/handson3/frontend/public:/home/myapp/public \
    -d nginx

docker run  \
    --name nginx-proxy \
    --network handson3net \
    --ip 172.18.0.12 \
    -v /home/ddya/cse-tot/reading/handson3/thirdstep/nginxproxy:/etc/nginx/conf.d \
    -p 127.0.0.1:80:80 \
    -d nginx

docker run \
    --name session-db \
    --network handson3net \
    --ip 172.18.0.13 \
    -d redis

docker run  \
    --name frontend-backup1 \
    --network handson3net \
    --ip 172.18.0.14 \
    --add-host shipping:172.18.0.3 \
    --add-host user:172.18.0.4 \
    --add-host orders:172.18.0.5 \
    --add-host carts:172.18.0.6 \
    --add-host payment:172.18.0.7 \
    --add-host catalogue:172.18.0.8 \
    --add-host session-db:172.18.0.13 \
    -e SESSION_REDIS=true \
    -d dplsming/sockshop-frontend:0.1

docker run  \
    --name frontend-backup2 \
    --network handson3net \
    --ip 172.18.0.15 \
    --add-host shipping:172.18.0.3 \
    --add-host user:172.18.0.4 \
    --add-host orders:172.18.0.5 \
    --add-host carts:172.18.0.6 \
    --add-host payment:172.18.0.7 \
    --add-host catalogue:172.18.0.8 \
    --add-host session-db:172.18.0.13 \
    -e SESSION_REDIS=true \
    -d dplsming/sockshop-frontend:0.1

docker run  \
    --name frontend-backup3 \
    --network handson3net \
    --ip 172.18.0.16 \
    --add-host shipping:172.18.0.3 \
    --add-host user:172.18.0.4 \
    --add-host orders:172.18.0.5 \
    --add-host carts:172.18.0.6 \
    --add-host payment:172.18.0.7 \
    --add-host catalogue:172.18.0.8 \
    --add-host session-db:172.18.0.13 \
    -e SESSION_REDIS=true \
    -d dplsming/sockshop-frontend:0.1

docker run  \
    --name frontend-backup4 \
    --network handson3net \
    --ip 172.18.0.17 \
    --add-host shipping:172.18.0.3 \
    --add-host user:172.18.0.4 \
    --add-host orders:172.18.0.5 \
    --add-host carts:172.18.0.6 \
    --add-host payment:172.18.0.7 \
    --add-host catalogue:172.18.0.8 \
    --add-host session-db:172.18.0.13 \
    -e SESSION_REDIS=true \
    -d dplsming/sockshop-frontend:0.1
