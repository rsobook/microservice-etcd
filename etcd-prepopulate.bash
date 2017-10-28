#!/bin/bash

# prepopulate with default values
docker exec etcd etcdctl mk ads/enabled false
docker exec etcd etcdctl mk log/level info
docker exec etcd etcdctl mk lists/users 10
docker exec etcd etcdctl mk lists/friends 10
docker exec etcd etcdctl mk lists/pets 10
docker exec etcd etcdctl mk images/maxsize 2000000
docker exec etcd etcdctl mk msg/ttl 604800
docker exec etcd etcdctl mk msg/maxchatusers 5

