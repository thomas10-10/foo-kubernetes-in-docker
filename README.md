# foo-kubernetes-in-docker
An easy and customisable way to create cluster kubernetes in docker containers just with the cli docker and systemd+docker images

## GET-started
Creates images ubuntu-systemd-docker and ubuntu-systemd-docker-kubeadm
https://github.com/thomas10-10/Dockerfile

```
cd /tmp/
wget https://raw.githubusercontent.com/thomas10-10/Dockerfile/main/ubuntu-systemd-docker/Dockerfile
docker build -t ubuntu-systemd-docker .  ; rm -f Dockerfile
wget https://raw.githubusercontent.com/thomas10-10/Dockerfile/main/ubuntu-systemd-docker-kubeadm/Dockerfile
docker build -t ubuntu-systemd-docker-kubeadm . ; rm -f Dockerfile
```

Run an example like singleMaster-docker-calico.sh

```
git clone 
cd /examples/
chmod +x singleMaster-docker-calico.sh
./singleMaster-docker-calico.sh create
```
wait for script finish

to manage:
```
./singleMaster-docker-calico.sh manage
#/ k get nodes -A
```


