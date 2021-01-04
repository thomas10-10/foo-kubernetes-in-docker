# foo-kubernetes-in-docker
An easy and customisable way to create cluster kubernetes in docker containers just with the cli docker and systemd+docker images

## GET-started
Creates images ubuntu-systemd-docker and ubuntu-systemd-docker-kubeadm
https://github.com/thomas10-10/Dockerfile

```
cd /tmp/
curl https://raw.githubusercontent.com/thomas10-10/Dockerfile/main/ubuntu-systemd-docker/Dockerfile -o Dockerfile
docker build -t ubuntu-systemd-docker . 
curl https://raw.githubusercontent.com/thomas10-10/Dockerfile/main/ubuntu-systemd-docker-kubeadm/Dockerfile -o Dockerfile
docker build -t ubuntu-systemd-docker-kubeadm . ; rm -f Dockerfile
```

Run an example like singleMaster-docker-calico.sh

```
cd $HOME
git clone https://github.com/thomas10-10/foo-kubernetes-in-docker.git
cd foo-kubernetes-in-docker/examples/
```
or

```
cd $HOME
curl -o https://raw.githubusercontent.com/thomas10-10/foo-kubernetes-in-docker/main/examples/singleMaster-docker-calico.sh -o singleMaster-docker-calico.sh
```

to create :

```
chmod +x singleMaster-docker-calico.sh
./singleMaster-docker-calico.sh create
```


wait until the script is finished

to manage:
```
./singleMaster-docker-calico.sh manage
root@b3238197605b:/# k get pods -A
NAMESPACE     NAME                                      READY   STATUS    RESTARTS   AGE
kube-system   calico-kube-controllers-bcc6f659f-chb49   1/1     Running   0          102s
kube-system   calico-node-bllcn                         1/1     Running   0          92s
kube-system   calico-node-fwj6n                         1/1     Running   0          102s
kube-system   calico-node-vlmlf                         1/1     Running   0          95s
kube-system   coredns-74ff55c5b-c4kxl                   1/1     Running   0          102s
kube-system   coredns-74ff55c5b-wqpts                   1/1     Running   0          102s
kube-system   etcd-b3238197605b                         1/1     Running   0          114s
kube-system   kube-apiserver-b3238197605b               1/1     Running   0          114s
kube-system   kube-controller-manager-b3238197605b      1/1     Running   0          114s
kube-system   kube-proxy-47vcl                          1/1     Running   0          95s
kube-system   kube-proxy-8q9vn                          1/1     Running   0          92s
kube-system   kube-proxy-mrk8j                          1/1     Running   0          102s
kube-system   kube-scheduler-b3238197605b               1/1     Running   0          114s
```


