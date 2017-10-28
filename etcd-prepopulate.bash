#!/bin/bash

# prepopulate with default values
docker exec rsobook_etcd etcdctl mk ads/enabled false
docker exec rsobook_etcd etcdctl mk log/level info
docker exec rsobook_etcd etcdctl mk lists/users 10
docker exec rsobook_etcd etcdctl mk lists/friends 10
docker exec rsobook_etcd etcdctl mk lists/pets 10
docker exec rsobook_etcd etcdctl mk msg/ttl 604800
docker exec rsobook_etcd etcdctl mk msg/maxchatusers 5

docker exec rsobook_etcd etcdctl mk environments/dev/services/rsobook-image-microservice/1.0.0/config/properties/maxsize 2000000

echo ""
echo "Current keys and values:"

docker exec rsobook_etcd /bin/sh -c "etcdctl ls --recursive -p | grep -v '/$' | xargs -n 1 -I% sh -c 'echo -n %:; etcdctl get %;'"

