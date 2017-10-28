# etcd scripts for RsoBook

**etcd-startup.bash** will create a new docker volume "rsobook-etcd-data" and use it for an etcd config server in a new docker container named "rsobook_etcd". If the volume "rsobook-etcd-data" already exists, it is reused (configuration is preserved even when container is deleted).

**etcd-prepopulate.bash** will create the keys that our microservices need with the default values. This has to be called when docker volume is first created.

To start the etcd container, run:

````
./etcd-startup.bash
````

To stop/resume the container, run:

````
docker stop rsobook_etcd
````


To remove the container and delete all values, run:

````
docker stop rsobook_etcd
docker rm rsobook_etcd
docker volume rm rsobook-etcd-data
````
