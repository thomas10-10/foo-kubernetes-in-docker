name_pattern=$(basename "$0" | cut -f1 -d '.')


if [[ $1 == "create" ]]
then

bash -c 'docker build -t ubuntu-systemd-docker . -f-<<<$(curl https://raw.githubusercontent.com/thomas10-10/Dockerfile/main/ubuntu-systemd-docker/Dockerfile)'
bash -c 'docker build -t ubuntu-systemd-docker-kubeadm . -f-<<<$(curl https://raw.githubusercontent.com/thomas10-10/Dockerfile/main/ubuntu-systemd-docker-kubeadm-haproxy/Dockerfile)'
imageNode="ubuntu-systemd-docker-kubeadm-haproxy"


masters="$name_pattern-master1 $name_pattern-master2 $name_pattern-master3"
workers="$name_pattern-worker1 $name_pattern-worker2 $name_pattern-worker3"

# DELETE CONTAINERS IF EXIST
for host in $masters $workers; do
	docker rm -f $host 2>/dev/null
	docker run -d --name $host --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro --memory-swappiness 0  -device=/proc/sys/net/bridge:/proc/sys/net/bridge  $imageNode
done


# CONFIG HAPROXY
haproxy_cfg="$(curl https://raw.githubusercontent.com/thomas10-10/foo-kubernetes-in-docker/main/ress/haproxy.cfg)"
for host in $masters; do
	haproxy_cfg="$haproxy_cfg\n    server $host $(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $host):6443 check"
done

# SET HAPROXY CONFIG
for host in $masters $workers; do
	docker exec $host bash -c "echo -e '$haproxy_cfg' > /etc/haproxy/haproxy.cfg ; systemctl restart haproxy "
done

# [INIT CLUSTER]
docker exec $name_pattern-master1 bash -c "kubeadm init  --upload-certs --apiserver-cert-extra-sans '127.0.0.1' --control-plane-endpoint '127.0.0.1:5443' --ignore-preflight-errors FileContent--proc-sys-net-bridge-bridge-nf-call-iptables  --ignore-preflight-errors Swap --pod-network-cidr=10.244.0.0/16 "

# [GET TOKENS]
token_join_worker_command="$(docker exec $name_pattern-master1 bash -c 'kubeadm token create --print-join-command') --ignore-preflight-errors FileContent--proc-sys-net-bridge-bridge-nf-call-iptables  --ignore-preflight-errors Swap"
token_join_master_command="$token_join_worker_command --certificate-key $(docker exec $name_pattern-master1 bash -c 'kubeadm init phase upload-certs --upload-certs | tail -1') --control-plane"
echo -e "$token_join_worker_command \n$token_join_master_command"


# [SET KUBECTL]
for host in $masters; do
	docker exec $host bash -c "echo 'export KUBECONFIG=/etc/kubernetes/admin.conf ; alias k=kubectl'  >> /root/.bashrc ; "
done

# [APPLY CALICO]
docker exec $name_pattern-master1 bash -c "export KUBECONFIG=/etc/kubernetes/admin.conf ; kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml"


sleep 90
# Add nodes to cluster
docker exec $name_pattern-master2 bash -c "$token_join_master_command"
sleep 90
docker exec $name_pattern-master3 bash -c "$token_join_master_command"


docker inspect --format '{{ .Config.Hostname }}' singleMaster-docker-calico-master1

for host in $workers; do
	docker exec $host bash -c "$token_join_worker_command"
	docker exec $name_pattern-master1 bash -c "export KUBECONFIG='/etc/kubernetes/admin.conf' ; kubectl label node $(docker inspect --format '{{ .Config.Hostname }}' $host)  node-role.kubernetes.io/worker=worker"

done



fi



# [COMMAND TO MANAGE]
if [[ $1 == "delete" ]]
then

docker rm -f $name_pattern-master{1..20} 2>/dev/null
docker rm -f $name_pattern-worker{1..20} 2>/dev/null

fi
if [[ $1 == "manage" ]]
then

	if [[ $2 != "" ]]
	then
	docker exec -ti $name_pattern-$2 bash
	else
        docker exec -ti $name_pattern-master1 bash
	fi

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
