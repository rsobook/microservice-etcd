#!/bin/sh

NODE1=127.0.0.1

echo ""
echo ""
echo ""
echo "Startup"
echo ""
echo ""

(   sleep 10
    echo ""
    echo "Prepopulating values"

    etcdctl mk environments/dev/services/microservice-ads/1.0.0/config/properties/ads/enabled false
    etcdctl mk environments/dev/services/microservice-user/1.0.0/config/properties/lists/users 10
    etcdctl mk environments/dev/services/microservice-friends/1.0.0/config/properties/lists/friends 10
    etcdctl mk environments/dev/services/microservice-pet/1.0.0/config/properties/lists/pets 10
    etcdctl mk environments/dev/services/microservice-chatrelay/1.0.0/config/properties/msg/maxchatusers 5
    etcdctl mk environments/dev/services/microservice-images/1.0.0/config/properties/maxsize 2000000

    echo ""
    echo "Current keys and values:"

    etcdctl ls --recursive -p | grep -v '/$' | xargs -n 1 -I% sh -c 'echo -n %:; etcdctl get %;'
) &

echo "Starting etcd..."
/usr/local/bin/etcd \
--data-dir=/etcd-data \
--name node1 \
--initial-advertise-peer-urls http://${NODE1}:2380 \
--listen-peer-urls http://0.0.0.0:2380 \
--advertise-client-urls http://${NODE1}:2379 \
--listen-client-urls http://0.0.0.0:2379 \
--initial-cluster node1=http://${NODE1}:2380
