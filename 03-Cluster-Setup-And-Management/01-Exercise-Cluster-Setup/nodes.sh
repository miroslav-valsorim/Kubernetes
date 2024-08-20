# applies to all 3 nodes

vi /etc/network/interfaces
# change 
# iface enp0s3 inet dhcp
# to
# iface enp0s3 inet static
#       address 'ipaddresshere'   192.168.1.201 / 192.168.1.202 / 192.168.1.203
#       gateway 'gatewayaddresshere' 192.168.81.1
reboot

# connect to all 3 machines via SSH in 3 separate terminals
ssh root@192.168.1.201
ssh root@192.168.1.202
ssh root@192.168.1.203

hostnamectl set-hostname node-1.k8s
exit
ssh root ... # again
hostnamectl set-hostname node-2.k8s
exit
ssh root ... # again
hostnamectl set-hostname node-3.k8s
exit
ssh root ...

# edit the etc/host for all the machines so they can connect through names

echo "192.168.1.201 node-1.k8s node-1" | tee -a /etc/hosts
echo "192.168.1.202 node-2.k8s node-2" | tee -a /etc/hosts
echo "192.168.1.203 node-3.k8s node-3" | tee -a /etc/hosts

# from node 1 for an example ping node 3 to check the connection
ping node-3