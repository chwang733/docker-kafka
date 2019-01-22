#!/bin/bash
#start zookeeper and kafka broker
echo "start zookeeper......"
docker run -d --name zookeeper --network kafkanet -p 2181:2181 jplock/zookeeper:3.4.13
echo "start kafka broker ......"
docker run -d --name kafka --network kafkanet -p 9092:9092 -e ZOOKEEPER_IP=zookeeper -e KAFKA_ADVERTISED_HOST_NAME=192.168.1.20 chwang733/kafka:2.1.0
docker run -d --name kafka1 --network kafkanet -p 9093:9093 -e ZOOKEEPER_IP=zookeeper -e KAFKA_ADVERTISED_PORT=9093 -e KAFKA_PORT=9093 -e KAFKA_BROKER_ID=1 -e KAFKA_ADVERTISED_HOST_NAME=192.168.1.20 chwang733/kafka:2.1.0
docker run -d --name kafka2 --network kafkanet -p 9094:9094 -e ZOOKEEPER_IP=zookeeper -e KAFKA_ADVERTISED_PORT=9094 -e KAFKA_PORT=9094 -e KAFKA_BROKER_ID=2 -e KAFKA_ADVERTISED_HOST_NAME=192.168.1.20 chwang733/kafka:2.1.0
