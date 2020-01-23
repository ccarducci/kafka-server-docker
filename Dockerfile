FROM ubuntu:latest

MAINTAINER Cristiano Carducci version: 0.1

RUN apt-get update && apt-get install -y wget &&  apt update && apt install -y  default-jre &&  apt install -y curl && java -version
RUN mkdir /home/kafka && cd  /home/kafka && curl "https://www.apache.org/dist/kafka/2.1.1/kafka_2.11-2.1.1.tgz" --output /home/kafka/kafka_2.11-2.1.1.tgz
RUN tar -xvzf /home/kafka/kafka_2.11-2.1.1.tgz 
RUN chmod -R 777 /home/kafka 
RUN ls /home/kafka/kafka_2.11-2.1.1 && cd /home/kafka/kafka_2.11-2.1.1

EXPOSE 2181
EXPOSE 9090
EXPOSE 9091
EXPOSE 9092

ADD . /config_kakfa
RUN ls /config_kakfa
RUN ls /kafka_2.11-2.1.1

COPY  chmod -R 777 /kafka_2.11-2.1.1 

#COPY  /kafka/server1.properties /home/kafka/kafka_2.11-2.1.1/server1.properties
#COPY  /kafka/server2.properties /home/kafka/kafka_2.11-2.1.1/server2.properties
#COPY  /kafka/server2.properties /home/kafka/kafka_2.11-2.1.1/server3.properties

#nohup bash -c "scripts/init.sh &"

RUN nohup bash -c "/home/kafka/kafka_2.11-2.1.1/bin/zookeeper-server-start.sh /kafka_2.11-2.1.1/config/zookeeper.properties  &"
RUN nohup bash -c "/home/kafka/kafka_2.11-2.1.1/bin/kafka-server-start.sh     /home/kafka/kafka_2.11-2.1.1/server1.properties   &"
RUN nohup bash -c "/home/kafka/kafka_2.11-2.1.1/bin/kafka-server-start.sh     /home/kafka/kafka_2.11-2.1.1/server2.properties  &"
RUN nohup bash -c "/home/kafka/kafka_2.11-2.1.1/bin/kafka-server-start.sh     /home/kafka/kafka_2.11-2.1.1/server3.properties  &"

#docker run -ti -p 2181:2181 -p 9090:9090 -p 9091:9091 -p 9092:9092 -v C:\Sviluppo\Docker\kafka:/kafka ubuntu /bin/bash
