# use the vagrant from Setup Cluset homework ex3
vagrant up

vagrant ssh node1

# check the cluster config file
cat ~/.kube/config

# create new user (os users)
sudo useradd -m -s /bin/bash miro
sudo passwd miro

cd /home/miro
sudo mkdir .certs
cd .certs/

sudo openssl genrsa -out miro.key 2048
ls

sudo openssl req -new -key miro.key -out miro.csr -subj "/CN=miro"
ls

sudo openssl x509 -req -in miro.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out miro.crt -days 365
ls

# return to home user
cd

# kubectl config set-credentials miro --client-certificate=/home/miro/.certs/miro.crt --client-key=/home/miro/.certs/miros.key
sudo mkdir -p /home/miro/.kube

sudo cat /etc/kubernetes/admin.conf

sudo vi /home/miro/.kube/config
# paste the copied from above command (sudo cat /etc/kubernetes/admin.conf)
# apiVersion: v1
# clusters:
# - cluster:
#     certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJS2ZZYjJTY2ZWOWt3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBNE1qY3hNak14TURCYUZ3MHpOREE0TWpVeE1qTTJNREJhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUMyR0ZTU2tWWWMvVThBbmg1aksraGhKVm9Qa3JTQm1PWmFKbk8zb1RmeEZEZjFaM2grd3pvaGk5S0kKOStnRWJQRDV4RVRDMW5oTXgwK1NJWW1USU9vTEVXRjk1VHVvODd3T2lJc1ZRaDUzR0Y5RlJzSGZaczZFUzNvcAptSDN4K245R1paaWFJK1FseHdES0xFeVZreXlPdWo1bjNPQnhRUXd1cjhLQy9xRUNXVjJDWHRDNXNjYkxmdVZ3CmZsM054MHdGdGlMeWpkWkRZL1FGNnZGUWJOMHdJdDZqL2dpODdJWnJMUmxXejB3WU5CelIvMVEySDdkWitrWXYKVzQxcTFaRWp2djdweWw3TjBnQUViZXV4cnkyR2ZXT1JydDZwcUl6NWV5eVBSWnNuSmhiOXJvdnRrcGtGbVFhSgplMkxadDUvUW53WlR5N05IeUhmWWlTR1g5UUR2QWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJRUEllSjFHZC9ZelhHWEw4SGErWjk1T3QrYlRUQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQU1oWjlHalJTRgp4RzB4UFZEa254RUt0bnRGTXBTQkZjVGdDUzVBMGZRQXl1UWFadi9RZ3R3NFNNMGowTHRzMEFUM2ZudnpaczBCCjNmMTR0RUg0MTdjRFZiQ3VYMHMvV3BzazBSSHN3S2RHSTloL1Y2YnJsT1lXVDd4SWFIeklWYUNQZGFlRzQ1MG0KeGNIQzc1L2VXa3V4bXpzQnpEb2J4SytEYkRoK0w0Q0RTZXY1dHZPZUZXNUNpM0lYRXFCaFlXS2QrMG94UjBNYgpVeDVkWm0zMmFZRWczNGdsU1d4eFlHWHVnWkJDVEFRMHNGclVveTE1em94eDUvdUZYZXlUR1U5NXVWREZSaStyCkRpUHlVK0MrMmxLaTAvaXV6bFNBc2tacG9nVWlNWGpsVFozY3UxcGs1SVR5MzdHdldPbDBxVy9WaTZBMlpEdEoKcU5HUHdSR2piTkx6Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
#     server: https://192.168.99.101:6443
#   name: kubernetes
# contexts:
# - context:
#     cluster: kubernetes
#     user: kubernetes-admin
#   name: kubernetes-admin@kubernetes
# current-context: kubernetes-admin@kubernetes
# kind: Config
# preferences: {}

# change the above to to be the same as screenshot 3 from the README

sudo chown -R miro: /home/miro

kubectl create namespace demo-dev
kubectl create namespace demo-prod
kubectl get nscle

# log with the acc
su - miro

kubectl get cluster-info
# no permissions

exit

# create new folder
# put the miro-role-bindings.yaml in it and the context in it

kubectl apply -f miro-role-bindings.yaml
kubectl get rolebinding -n demo-dev
kubectl get rolebinding -n demo-prod

kubectl run pod-prod --image=shekeriev/k8s-oracle --labels=app=oracle --namespace demo-prod
kubectl run pod-dev --image=shekeriev/k8s-oracle --labels=app=oracle --namespace demo-dev

kubectl get pods -n demo-prod
kubectl get pods -n demo-dev

# log with the acc
su - miro

# have access to create
kubectl run pod-prod-miro --image=shekeriev/k8s-oracle --labels=app=oracle --namespace demo-prod

# doesn't have access to create
kubectl run pod-dev-miro --image=shekeriev/k8s-oracle --labels=app=oracle --namespace demo-dev

# have view access
kubectl get pods -d demo-prod
kubectl get pods -d demo-dev 

exit

kubectl auth can-i create pods
kubectl auth can-i create pods -n demo-prod
kubectl auth can-i create pods -n demo-dev
kubectl auth can-i create services

kubectl auth can-i create pods --as miro -n demo-prod
kubectl auth can-i create pods --as miro -n demo-dev

kubectl auth can-i --list --namespace demo-dev --as miro

kubectl delete namespace demo-prod demo-dev

#################################

kubectl create namespace rbac-ns
kubectl run rbac-pod --image=shekeriev/k8s-oracle --namespace=rbac-ns
kubectl expose pod rbac-pod --port=5000 --name=rbac-svc --namespace=rbac-ns

kubectl get serviceaccount -n rbac-ns

kubectl get pod rbac-pod -n rbac-ns -o yaml | grep serviceAccount

# get inside the created pod
kubectl exec -it rbac-pod -n rbac-ns -- bash

# install curl in the pod
apt-get update && apt-get install -y curl

# set envs
APISERVER=https://kubernetes.default.svc
SERVICEACCOUNT=/var/run/secrets/kubernetes.io/serviceaccount
NAMESPACE=$(cat ${SERVICEACCOUNT}/namespace)
TOKEN=$(cat ${SERVICEACCOUNT}/token)
CACERT=${SERVICEACCOUNT}/ca.crt

curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X GET ${APISERVER}/api

# error 403
curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X GET ${APISERVER}/api/v1/namespaces/rbac-ns/pods

# exit from pod
exit

kubectl auth can-i get pods --namespace rbac-ns --as system:serviceaccount:rbac-ns:default
kubectl auth can-i create pods --namespace rbac-ns --as system:serviceaccount:rbac-ns:default

kubectl get serviceaccount -n rbac-ns

kubectl get sa -n rbac-ns

# create role in the namespace ! NOT cluster role
kubectl create role view-pods --verb=get,list,watch --resource=pods --namespace=rbac-ns

kubectl create rolebinding view-pods --role=view-pods --serviceaccount=rbac-ns:default --namespace=rbac-ns

# get inside the created pod again
kubectl exec -it rbac-pod -n rbac-ns -- bash

# set envs
APISERVER=https://kubernetes.default.svc
SERVICEACCOUNT=/var/run/secrets/kubernetes.io/serviceaccount
NAMESPACE=$(cat ${SERVICEACCOUNT}/namespace)
TOKEN=$(cat ${SERVICEACCOUNT}/token)
CACERT=${SERVICEACCOUNT}/ca.crt

# try the command that was giving error 403 before, now it works
curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X GET ${APISERVER}/api/v1/namespaces/rbac-ns/pods

# again 403 because we haven't set permission for services
curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X GET ${APISERVER}/api/v1/namespaces/rbac-ns/services

kubectl auth can-i get pods --namespace rbac-ns --as system:serviceaccount:rbac-ns:default # yes
kubectl auth can-i get services --namespace rbac-ns --as system:serviceaccount:rbac-ns:default # no

kubectl get role view-pods -n rbac-ns -o yaml

# open and add also services
kubectl edit role view-pods -n rbac-ns

kubectl auth can-i get services --namespace rbac-ns --as system:serviceaccount:rbac-ns:default # now its yes


#################################
# create new service account

kubectl create serviceaccount demo-sa --namespace rbac-ns

kubectl auth can-i get pods --namespace rbac-ns --as system:serviceaccount:rbac-ns:demo-sa # no
kubectl auth can-i get services --namespace rbac-ns --as system:serviceaccount:rbac-ns:demo-sa # no

# check account (have to be 2, the default + the new one)
kubectl get serviceaccount -n rbac-ns

# add the demo-role.yaml and its context in the folder created earlyer

kubectl apply -f demo-role.yaml
kubectl create rolebinding demo-role --role=demo-role --serviceaccount=rbac-ns:demo-sa --namespace=rbac-ns

kubectl auth can-i get pods --namespace rbac-ns --as system:serviceaccount:rbac-ns:demo-sa # yes
kubectl auth can-i get services --namespace rbac-ns --as system:serviceaccount:rbac-ns:demo-sa # yes
kubectl auth can-i delete pods --namespace rbac-ns --as system:serviceaccount:rbac-ns:demo-sa # yes
kubectl auth can-i delete services --namespace rbac-ns --as system:serviceaccount:rbac-ns:demo-sa # no

# add the demo-pod.yaml and its context in the folder created earlyer

kubectl apply -f demo-pod.yaml

# enter the pod and install curl 
kubectl exec -it demo-pod -n rbac-ns -- bash
apt-get update && apt-get install -y curl

# set envs
APISERVER=https://kubernetes.default.svc
SERVICEACCOUNT=/var/run/secrets/kubernetes.io/serviceaccount
NAMESPACE=$(cat ${SERVICEACCOUNT}/namespace)
TOKEN=$(cat ${SERVICEACCOUNT}/token)
CACERT=${SERVICEACCOUNT}/ca.crt

curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X GET ${APISERVER}/api/v1/namespaces/rbac-ns/pods # works
curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X GET ${APISERVER}/api/v1/namespaces/rbac-ns/services # works
curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X DELETE ${APISERVER}/api/v1/namespaces/rbac-ns/services/rbac-svc # doesnt work no permission
curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X DELETE ${APISERVER}/api/v1/namespaces/rbac-ns/pods/rbac-pod # works

exit