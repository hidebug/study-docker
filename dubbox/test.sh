#!/bin/bash

cp -f zk/zoo.cfg zk/zoo_m.cfg

i=1
while [ $i -le 3 ]
do      
       echo "server.$i=dubbox_$i.hidebug.com:2888:3888 " >> zk/zoo_m.cfg
       ((i++))
done

i=1
while [ $i -le 3 ]
do      
       echo $i > zk/myid
       sudo docker cp zk/myid dubbox_$i:/root/zookeeper/myid
       sudo docker cp zk/zoo_m.cfg dubbox_$i:/opt/zookeeper-3.4.6/conf/zoo.cfg
       docker exec -u root -d dubbox_$i sh -c "/opt/zookeeper-3.4.6/bin/zkServer.sh restart"
       ((i++))
done
rm zk/myid
rm zk/zoo_m.cfg

