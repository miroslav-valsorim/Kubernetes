# Control Plane Node / Cluster Initialization

# https://zahariev.pro/go/k8s-templates

kubeadm init --apiserver-advertise-address=192.168.1.201 --pod-network-cidr 10.244.0.0/16

# save the info after initialization from the terminal !

# To start using our cluster, we must execute the following
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get nodes # node wont be ready
kubectl get pods -n kube-system # check coredns-... both are pending
kubectl describe node node-1 # at conditions, ready = False, KubeletNotReady container runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized

# https://kubernetes.io/docs/concepts/cluster-administration/addons/
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#pod-network
# https://kubernetes.io/docs/concepts/cluster-administration/networking/#how-to-implement-the-kubernetes-networking-model

# https://github.com/flannel-io/flannel#flannel
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl get pods --all-namespaces -w  # now the problem from line 13-14 is done due to both coredns-... They are both running now
kubectl get nodes # status now is ready

# from the file after initialization at the bottom there will be a string "kubeadm join 192.168.1.201 -toke ....."
# copy that string and paste it into node-2 and node-3 this command allows them to join the control plane (node-1)
kubectl get nodes # check the available nodes now from node-1
kubectl cluster-info


# control the plane outside the node
exit
mkdir .kube 
#if exists
cd .kube
ls
ren config config.bak

# Copy the configuration file (use your actual master/node-1 IP address here) from the VM in your home folde
scp root@192.168.1.201:/etc/kubernetes/admin.conf .
ren .\admin.conf config
kubectl get nodes
cat config


kubectl apply -f producer-deployment.yml
kubectl get pods
kubectl get pods -o wide