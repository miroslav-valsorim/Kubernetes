# https://kubernetes.io/docs/tasks/administer-cluster/highly-available-control-plane/ 
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/ 
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ha-topology/ 
# https://github.com/kubernetes/kubeadm/blob/main/docs/ha-considerations.md

# login into ha-k8s-0lb (load balancer) with root
hostnamectl set-hostname lb.k8s

vi /etc/network/interfaces # set the address gatewat and static same from ex1-ex2 command is there
reboot

# login into ha-k8s-1-cp1 (control plane 1)
hostnamectl set-hostname cp1.k8s

vi /etc/network/interfaces # set the address gatewat and static same from ex1-ex2 command is there
reboot

# login into ha-k8s-2-cp2 (control plane 2)
hostnamectl set-hostname cp2.k8s

vi /etc/network/interfaces # set the address gatewat and static same from ex1-ex2 command is there
reboot

# login into ha-k8s-3-cp3 (control plane 3)
hostnamectl set-hostname cp3.k8s

vi /etc/network/interfaces # set the address gatewat and static same from ex1-ex2 command is there
reboot

# login into ha-k8s-4-wk1 (worker 1)
hostnamectl set-hostname wk1.k8s

vi /etc/network/interfaces # set the address gatewat and static same from ex1-ex2 command is there
reboot

# login into ha-k8s-5-wk2 (worker 2)
hostnamectl set-hostname wk2.k8s

vi /etc/network/interfaces # set the address gatewat and static same from ex1-ex2 command is there
reboot

# login into ha-k8s-6-wk3 (worker 3)
hostnamectl set-hostname wk3.k8s

vi /etc/network/interfaces # set the address gatewat and static same from ex1-ex2 command is there
reboot

# ssh to the load balancer
apt-get update
apt-get install haproxy


# edit /etc/haproxy/haproxy.cfg

# frontend kubernetes
# bind 192.168.81.210:6443
# option tcplog
# mode tcp
# default_backend kubernetes-cp
# backend kubernetes-cp
# option httpchk GET /healthz
# http-check expect status 200
# mode tcp
# option ssl-hello-chk
# balance roundrobin
# server cp1 192.168.81.211:6443 check fall 3 rise 2
# server cp2 192.168.81.212:6443 check fall 3 rise 2
# server cp3 192.168.81.213:6443 check fall 3 rise 2
# frontend stats
# bind 192.168.81.210:8080
# mode http
# stats enable
# stats uri /
# stats realm HAProxy\ Statistics
# stats auth admin:haproxy

systemctl restart haproxy

# edit hosts on all machines /etc/hosts

# echo "192.168.81.210 lb.k8s lb" | tee -a /etc/hosts
# echo "192.168.81.211 cp1.k8s cp1" | tee -a /etc/hosts
# echo "192.168.81.212 cp2.k8s cp2" | tee -a /etc/hosts
# echo "192.168.81.213 cp3.k8s cp3" | tee -a /etc/hosts
# echo "192.168.81.214 wk1.k8s wk1" | tee -a /etc/hosts
# echo "192.168.81.215 wk2.k8s wk2" | tee -a /etc/hosts
# echo "192.168.81.216 wk3.k8s wk3" | tee -a /etc/hosts

exit


# login into cp1

docker info

# initializing the cluster
kubeadm init --control-plane-endpoint "192.168.81.210:6443" --upload-certs --pod-network-cidr 10.244.0.0/16 # pointing to the load balancer
# copy the info after the initialization

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get nodes

# join the rest of the control planes 1 by 1 with
kubeadm join 192.168.81.210:6443 --token ozo8xv.c5jz648l6tp50jqp \
--discovery-token-ca-cert-hash sha256:f7eff5b82343969492fb8f8f613dc7ff752dc2da06e5d79e69879d425e980121 \
--control-plane --certificate-key d6befa0a65edc6659e1bd56a4706de715c7e11499c2aaf0c4c3f5b7100e7f780

kubectl get nodes -o wide

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml