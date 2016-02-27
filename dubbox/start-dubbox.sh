#!/bin/bash

# run N dubbox note
N=$1

# the min node number is 3
if [ $# -lt 3 ]
then
	N=3
fi

echo "begin start dubbox node N=$N"	

# delete old master container and start new master container
# defualt max is 10
i=1
while [ $i -le 10 ]
do
    echo "remove old dubbox node dubbox_$i"
    sudo docker rm -f dubbox_$i &> /dev/null
    ((i++))
done

echo "start first dubbox note..."
sudo docker run -d -t --dns 127.0.0.1 -P --name dubbox_1 -h dubbox_1.hidebug.com -w /root ubuntu/dubbox_serf:2.4.8 &> /dev/null

# get the IP address of first dubbox note
FIRST_IP=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" dubbox_1)
echo "first dubbox node ip=$FIRST_IP"

echo "start new other dubbox node..."
i=2
while [ $i -le $N ]
do
	echo "start dubbox_$i note..."
	sudo docker run -d -t --dns 127.0.0.1 -P --name dubbox_$i -h dubbox_$i.hidebug.com -w /root -e JOIN_IP=$FIRST_IP ubuntu/dubbox_serf:2.4.8 &> /dev/null
	((i++))
done 

echo "update zk cluster config"
sleep 5
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
       sudo docker cp zk/zoo_m.cfg dubbox_$i:/opt/zookeeper/conf/zoo.cfg
       docker exec -u root -d dubbox_$i sh -c "/opt/zookeeper/bin/zkServer.sh restart"
       ((i++))
done
rm zk/myid
rm zk/zoo_m.cfg

sudo docker exec -it dubbox_1 bash
