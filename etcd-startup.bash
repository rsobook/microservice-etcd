#!/bin/bash

# docker needs to be running on the system before running the script


# most of the code is from https://github.com/coreos/etcd/blob/master/Documentation/op-guide/container.md#docker

NAME="rsobook-etcd-data"
REGISTRY="gcr.io/etcd-development/etcd"
export NODE1=127.0.0.1

no_volume=$(docker volume inspect $NAME 2>&1 >/dev/null | grep "No such volume")
if [ -n "$no_volume" ]; then
	echo ""
	echo "Creating a new docker volume 'rsobook-etcd-data'"
	echo "You will probably want to run"
	echo "        ./etcd-prepopulate.bash"
	echo "to set the default key values"
	echo ""
	docker volume create $NAME
else
	docker rm -f rsobook_etcd || true
fi

docker run \
  -d \
  -p 2379:2379 \
  -p 2380:2380 \
  --volume=${NAME}:/etcd-data \
  --name rsobook_etcd ${REGISTRY}:v3.2.9 \
  /usr/local/bin/etcd \
  --data-dir=/etcd-data --name node1 \
  --initial-advertise-peer-urls http://${NODE1}:2380 --listen-peer-urls http://0.0.0.0:2380 \
  --advertise-client-urls http://${NODE1}:2379 --listen-client-urls http://0.0.0.0:2379 \
  --initial-cluster node1=http://${NODE1}:2380

echo ""
echo ""
echo "Done, etcd should be running on localhost:2379"
echo "To stop the container, run:"
echo "        docker stop rsobook_etcd"
echo ""

# docker exec etcdctl --endpoints=http://${NODE1}:2379 member list


