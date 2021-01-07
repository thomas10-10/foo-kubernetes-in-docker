# foo-kubernetes-in-docker
An easy and customisable way to create cluster kubernetes in docker containers just with the cli docker and systemd+docker images

## Requirements

just docker ! tested on docker desktop for mac (docker with 5 cpu and 8gb ram run 3 master and 3 worker)

for multi master and multi worker you need > 30gb space

## GET-started

Run an example like multi-master-docker-calico.sh
```
cd $HOME
git clone https://github.com/thomas10-10/foo-kubernetes-in-docker.git
cd foo-kubernetes-in-docker/examples/
```
or
```
cd $HOME
curl https://raw.githubusercontent.com/thomas10-10/foo-kubernetes-in-docker/main/examples/multi-master-docker-calico.sh -o multi-master-docker-calico.sh
```

to create the cluster defined in this script :
```
chmod +x multi-master-docker-calico.sh
./multi-master-docker-calico.sh create
```

if you have a "dockerignore" error this is not a problem

wait until the script is finished

to manage:
```
./multi-master-docker-calico.sh manage
root@ad8d3974f396:/# k get nodes -A
NAME           STATUS   ROLES                  AGE   VERSION
0d9cce3677c7   Ready    worker                 31m   v1.20.1
33ba8fb171e2   Ready    worker                 31m   v1.20.1
62f62ec3c10c   Ready    control-plane,master   32m   v1.20.1
ad8d3974f396   Ready    control-plane,master   37m   v1.20.1
ba1fab008243   Ready    worker                 32m   v1.20.1
faf3e8e730a1   Ready    control-plane,master   34m   v1.20.1
```


