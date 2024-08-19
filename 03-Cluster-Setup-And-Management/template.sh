# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#before-you-begin

ssh root@192.168.1.12

# NETWORK SETTING

lsmod | grep br_netfilter # check for bridge netfilet modile
modprobe br_netfilter # loading the module
lsmod | grep br_netfilter # check again
# the above only applies for the current session, the commands below prevent that

# command 1
cat << EOF | tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

# command 2
cat << EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# applying the changes above to the current session
sysctl --system


update-alternatives --query iptables # check if iptables
apt-get install iptables # install iptables
update-alternatives --query iptables # check again
update-alternatives --set iptables /usr/sbin/iptables-legacy # switch to legacy
update-alternatives --query iptables # check again



## SWAP SETTING

free -h
# K8S nodes shouldn't have active SWAP !!!
swapoff -a # disables swap only for current session
sed -i '/swap/ s/^/#/' /etc/fstab # disables it permament
lsblk


## DOCKER SETTING
# https://docs.docker.com/engine/install/debian/

apt-get update
apt-get install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg # import the key to work with the docker repo
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update # update the information from the repositories
apt-get install docker-ce docker-ce-cli containerd.io # install the packages
docker info


## KUBERNETES SETTING
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl

apt-get update
apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.27/deb/Release.key | gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.27/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-cache madison kubelet
apt-get install kubelet=1.27.5-1.1 kubeadm=1.27.5-1.1 kubectl=1.27.5-1.1
apt-mark hold kubelet kubeadm kubectl # mark the k8s compononents to not upgrade automatically !
cp /etc/containerd/config.toml /etc/containerd/config.toml.bak # creates backup
containerd config default | tee /etc/containerd/config.toml > /dev/null
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml # change from false to true
sed -i 's/pause:3.6/pause:3.9/g' /etc/containerd/config.toml # change the image that the infrastructure container uses


systemctl restart containerd # restart to apply all the changes
poweroff

