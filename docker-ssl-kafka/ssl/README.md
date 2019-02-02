### Enable TLS on Kafka cluster ###

1. To enable TLS on Kafka cluster. The first step is to generate keystore and truststore. Make sure to use the target host name as CN when generating the server cert. You can use create-certs.sh to automate the process
2. server-ssl.properties is a sample Kafka broker configuration file. client-ssl.propertiesis a sample client configuration file
3. For running on windows local host:
	- Copy the localhost-certs folder to your local kafka installation folder
	- Copy server-ssl.properties and client-ssl.properties files to Kafka config folder
	- Use the following command lines to run the cluster and test it.
		- Zookeeper: ./zookeeper-server-start.sh ../config/zookeeper.properties
		- Broker: ./kafka-server-start.sh ../config/server-ssl.properties
		- Create topic: ./kafka-topics.sh --create --topic test-topic --zookeeper localhost:2181 --replication-factor 1 --partitions 1
		- Console-Producer: ./kafka-console-producer.sh --broker-list localhost:9092 --topic test-topic --producer.config ../config/client-ssl.properties
		- Console-Consumer: ./kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test-topic --consumer.config ../config/client-ssl.properties
