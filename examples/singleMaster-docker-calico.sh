imageNode="ubuntu-systemd-docker-kubeadm"

name_pattern=$(basename "$0" | cut -f1 -d '.')



if [[ $1 == "create" ]]
then

#rm containers if exist
docker rm -f $name_pattern-master{1..20} 2>/dev/null
docker rm -f $name_pattern-worker{1..20} 2>/dev/null

# create containers
docker run -d --name $name_pattern-master1 --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro $imageNode
docker run -d --name $name_pattern-worker1 --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro $imageNode
docker run -d --name $name_pattern-worker2 --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro $imageNode

# init cluster and get token on master1
token=$(docker exec $name_pattern-master1 bash -c "kubeadm init --ignore-preflight-errors FileContent--proc-sys-net-bridge-bridge-nf-call-iptables  --ignore-preflight-errors Swap --pod-network-cidr=10.244.0.0/16" | grep  -A1 "kubeadm join" )

#set kubectl for root in  master node
docker exec $name_pattern-master1 bash -c "echo 'export KUBECONFIG=/etc/kubernetes/admin.conf ; alias k=kubectl'  >> /root/.bashrc ; "
# Apply deployment calico
docker exec $name_pattern-master1 bash -c "export KUBECONFIG=/etc/kubernetes/admin.conf ; kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml"

# Add nodes to cluster
docker exec $name_pattern-worker1 bash -c "$token --ignore-preflight-errors Swap --ignore-preflight-errors FileContent--proc-sys-net-bridge-bridge-nf-call-iptables"
docker exec $name_pattern-worker2 bash -c "$token --ignore-preflight-errors Swap --ignore-preflight-errors FileContent--proc-sys-net-bridge-bridge-nf-call-iptables"

fi
if [[ $1 == "delete" ]]
then

docker rm -f $name_pattern-master{1..20} 2>/dev/null
docker rm -f $name_pattern-worker{1..20} 2>/dev/null

fi
if [[ $1 == "manage" ]]
then

docker exec -ti $name_pattern-master1 bash

fi
if [[ $1 == "start" ]]
then

docker start $name_pattern-master{1..20} 2>/dev/null
docker start $name_pattern-worker{1..20} 2>/dev/null

fi
if [[ $1 == "stop" ]]
then

docker stop $name_pattern-master{1..20} 2>/dev/null
docker stop $name_pattern-worker{1..20} 2>/dev/null

fi
