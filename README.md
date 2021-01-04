# foo-kubernetes-in-docker
An easy and customisable way to cluster kubernetes in docker containers just with the cli docker and systemd+docker images

## GET-started
Creates images ubuntu-systemd-docker and ubuntu-systemd-docker-kubeadm
https://github.com/thomas10-10/Dockerfile

Run an example like singleMaster-docker-calico.sh

```
chmod +x singleMaster-docker-calico.sh
./singleMaster-docker-calico.sh create
```
wait for script finish

to manage:
```
./singleMaster-docker-calico.sh manage
#/ k get nodes -A
```


