# continue with same setup from exercise 1

kubectl get pods

kubectl apply -f consumer-deployment.yml

kubectl apply -f consumer-svc.yml

kubectl apply -f producer-svc.yml

kubectl get pods,svc

# stop node-3

kubectl get nodes

kubectl get pods -o wide

kubectl describe service producer

kubectl describe service consumer

kubectl get pods -o wide

# turn on node-3

kubectl get pods -o wide

kubectl describe service producer

# stop node-3 again this time for maintanance

kubectl cordon node-3.k8s # cordon means that cluster wont send new 'work' to node-3

kubectl edit deployment producer-deploy

kubectl get pods -o wide # all pods are running on node-2

kubectl uncordon node-3.k8s # this won't make the pods autoamtically work on node-3 again


# DRAIN for manual upgrade

# deprecated
# kubectl drain node-3.k8s --ignore-daemonsets --delete-local-data --force 
kubectl drain node-3.k8s --ignore-daemonsets --delete-emptydir-data --force

kubectl get nodes

kubectl get pods -o wide

kubectl uncordon node-3.k8s

kubectl get pods -o wide # the pods wont go again to node-3 by themselfs


# Update Control Plane

ssh root@192.168.1.201

apt-get update

apt-cache madison kubeadm

#https://kubernetes.io/releases/

apt-get update && apt-get install -y --allow-change-held-packages kubeadm=1.27.7-1.1

kubeadm version

kubeadm upgrade plan
kubeadm upgrade plan --ignore-preflight-errors=true

kubeadm upgrade apply v1.27.7

# If we had other control plane nodes, then we must execute the following command on each one of them
# kubeadm upgrade node

kubectl drain node-1.k8s --ignore-errors --ignore-daemonsets --delete-emptydir-data --force

apt-get update && \
apt-get install -y --allow-change-held-packages kubelet=1.27.7-1.1 kubectl=1.27.7-1.1

systemctl daemon-reload

systemctl restart kubelet

kubectl uncordon node-1.k8s

kubectl get nodes

# Upgrade Nodes (node-2)

apt-get update && apt-get install -y --allow-change-held-packages kubeadm=1.27.7-1.1

kubeadm upgrade node

# should be executed from the Control Plane (node-1)
kubectl drain node-2.k8s --ignore-daemonsets
# or
kubectl drain node-2.k8s --ignore-daemonsets --delete-emptydir-data --force

# back on node-2
apt-get update && \
apt-get install -y --allow-change-held-packages kubelet=1.27.7-1.1 kubectl=1.27.7-1.1

systemctl daemon-reload

systemctl restart kubelet

kubectl uncordon node-2.k8s

kubectl get nodes

# Repeat the steps above for node-3

# etcd backup and restore ( on control plane node-1 )

apt-get update
apt-get install etcd-client

cat /etc/kubernetes/manifests/etcd.yaml

ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key \
snapshot save /tmp/etcd-snapshot.db

ls -al /tmp/etcd*

kubectl get pods
kubectl get pods -A

# restore
etcdutill snapshot restore /tmp/etcd-snapshot.db --data-dir /var/lib/etcd-restore \ 
--name=node-1.k8s --initial-cluster-toke=etcd-cluster-1 --initial-cluster=node-1.k8s \
https:/192.168.1.201:2380 --initial-advertise-peer-urls=https://192.168.1.201:2380

vi /etc/kubernetes/manifests/etcd.yaml # line 78 change the path and where the commands are add --initial-cluster_toke=etcd-cluster-1

kubectl get pods