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

    etcdctl mk environments/dev/services/ms.ads/1.0.0/config/properties/ads-enabled false
    etcdctl mk environments/dev/services/ms.user/1.0.0/config/properties/lists-users 10
    etcdctl mk environments/dev/services/ms.friends/1.0.0/config/properties/lists-friends 10
    etcdctl mk environments/dev/services/ms.pet/1.0.0/config/properties/lists-pets 10
    etcdctl mk environments/dev/services/ms.chatrelay/1.0.0/config/properties/max-chat-users 5
    etcdctl mk environments/dev/services/ms.chatroom/1.0.0/config/properties/max-rooms 15
    etcdctl mk environments/dev/services/ms.images/1.0.0/config/properties/max-size 2000000
    etcdctl mk environments/dev/services/ms.wall/1.0.0/config/properties/max-wall-posts 5

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
