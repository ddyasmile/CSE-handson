docker network create \
    --subnet=172.18.0.0/16 \
    --gateway=172.18.0.1 \
    handson3net

docker run \
    --name zookeeper \
    --net handson3net \
    --ip 172.18.0.2 \
    -p 127.0.0.1:2191:2181 \
    -d zookeeper:latest

docker run  \
    --name frontend \
    --network handson3net \
    --ip 172.18.0.3 \
    -d -p 127.0.0.1:80:8079 \
    frontend/frontend:01

docker run  \
    --name shipping \
    --network handson3net \
    --ip 172.18.0.4 \
    -d shipping/shipping:01

docker run  \
    --name user \
    --network handson3net \
    --ip 172.18.0.5 \
    -e MONGO_HOST=user-db:27017 \
    -d user/user:01

docker run  \
    --name orders \
    --network handson3net \
    --ip 172.18.0.6 \
    -d orders/orders:01

docker run  \
    --name carts \
    --network handson3net \
    --ip 172.18.0.7 \
    -d cart/cart:01

docker run  \
    --name payment \
    --network handson3net \
    --ip 172.18.0.8 \
    -d payment/payment:01

docker run  \
    --name catalogue \
    --network handson3net \
    --ip 172.18.0.9 \
    -d catalogue/catalogue:01

docker run  \
    --name carts-mongo-db \
    --network handson3net \
    --ip 172.18.0.10 \
    -d mongo:3.4

docker run  \
    --name user-mongo-db \
    --network handson3net \
    --ip 172.18.0.11 \
    -d mongo:3.4

docker run  \
    --name orders-mongo-db \
    --network handson3net \
    --ip 172.18.0.12 \
    -d mongo:3.4

docker run  \
    --name catalogue-db \
    --network handson3net \
    --ip 172.18.0.13 \
    -d catalogue-db/catalogue-db:01

