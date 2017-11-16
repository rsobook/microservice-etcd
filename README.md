# RsoBook etcd

Dockerfile takes the image from gcr.io/etcd-development/etcd:v3.2.9 and adds a custom startup script (*etcd-startup.sh*) to it.

The startup script will start etcd, wait 10 seconds and set all the default values. Default values can be changed inside the script.
