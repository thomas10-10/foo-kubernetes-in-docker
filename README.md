# foo-kubernetes-in-docker
An easy and customisable way to create cluster kubernetes in docker containers just with the cli docker and systemd+docker images

## GET-started

Run an example like singleMaster-docker-calico.sh
```
cd $HOME
git clone https://github.com/thomas10-10/foo-kubernetes-in-docker.git
cd foo-kubernetes-in-docker/examples/
```
or
```
cd $HOME
curl https://raw.githubusercontent.com/thomas10-10/foo-kubernetes-in-docker/main/examples/singleMaster-docker-calico.sh -o singleMaster-docker-calico.sh
```

to create the cluster defined in this script :
```
chmod +x singleMaster-docker-calico.sh
./singleMaster-docker-calico.sh create
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


