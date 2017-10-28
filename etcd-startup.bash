#!/bin/bash

# docker needs to be running on the system before running the script


# most of the code is from https://github.com/coreos/etcd/blob/master/Documentation/op-guide/container.md#docker

NAME="rsobook-etcd-data"
REGISTRY="gcr.io/etcd-development/etcd"
export NODE1=127.0.0.1

function run-in-docker {
	docker rm -f etcd || true
	docker run \
	  -p 2379:2379 \
	  -p 2380:2380 \
	  --volume=${NAME}:/etcd-data \
	  --name etcd ${REGISTRY}:v3.2.9 \
	  /usr/local/bin/etcd \
	  --data-dir=/etcd-data --name node1 \
	  --initial-advertise-peer-urls http://${NODE1}:2380 --listen-peer-urls http://0.0.0.0:2380 \
	  --advertise-client-urls http://${NODE1}:2379 --listen-client-urls http://0.0.0.0:2379 \
	  --initial-cluster node1=http://${NODE1}:2380
}


if docker volume inspect $NAME | grep "No such volume"; then
	echo "Using existing docker volume rsobook-etcd-data"
	run-in-docker
else
	# create the volume and start the docker container
	docker volume create $NAME
	run-in-docker
fi

# docker exec etcdctl --endpoints=http://${NODE1}:2379 member list


