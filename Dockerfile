FROM gcr.io/etcd-development/etcd:v3.2.9
MAINTAINER Nejc Kisek "nk4741@student.uni-lj.si"
EXPOSE 2379:2379
EXPOSE 2380:2380

ADD initscripts/etcd-startup.sh /usr/bin/etcd-startup.sh

CMD /bin/sh /usr/bin/etcd-startup.sh