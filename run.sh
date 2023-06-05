#!/bin/bash
echo 'clientPort=2181' > zookeeper.properties
echo 'dataDir=/var/lib/zookeeper/data' >> zookeeper.properties
echo 'dataLogDir=/var/lib/zookeeper/log' >> zookeeper.properties
zookeeper-server-start zookeeper.properties &

echo '' > /etc/confluent/docker/ensure
/etc/confluent/docker/run
