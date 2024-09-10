# Create the two users
useradd -m -c 'Ivan' -s /bin/bash ivan
useradd -m -c 'Mariana' -s /bin/bash mariana

# Prepare the subfolders for both users
mkdir -p /home/{ivan,mariana}/{.certs,.kube

# Create the private keys for both users
openssl genrsa -out /home/ivan/.certs/ivan.key 2048
openssl genrsa -out /home/mariana/.certs/mariana.key 2048

# Create a certificate signing request (CSR) for every user
openssl req -new -key /home/ivan/.certs/ivan.key-out/home/ivan/.certs/ivan.csr-subj"/CN=ivan/O=gurus"
openssl req -new -key /home/mariana/.certs/mariana.key-out/home/mariana/.certs/mariana.csr-subj"/CN=mariana/O=gurus"

# Sign both CSRs with the Kubernetes CA certificate
openssl x509-req-in /home/ivan/.certs/ivan.csr-CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out /home/ivan/.certs/ivan.crt -days 365
openssl x509-req-in /home/mariana/.certs/mariana.csr-CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out /home/mariana/.certs/mariana.crt -days 365

# Create the credentials for the two users
kubectl config set-credentials ivan --client-certificate=/home/ivan/.certs/ivan.crt--client-key=/home/ivan/.certs/ivan.key
kubectl config set-credentials mariana --client-certificate=/home/mariana/.certs/ivan.crt--client-key=/home/mariana/.certs/mariana.key

# Create the contexts for the two users
kubectl config set-context ivan-context --cluster=kubernetes --user=ivan
kubectl config set-context mariana-context --cluster=kubernetes --user=mariana

Create configuration file for ivan at /home/ivan/.kube/config with the following content:
# check ivan.yml

Create configuration file for mariana at /home/mariana/.kube/config with the following content:
# check mariana.yml

# change the ownership of the respective folders and files
chown -R ivan: /home/ivan
chown -R mariana: /home/mariana

# Each one of them will be able to use kubectl but without much success

# TASK 2

kubectl create ns projectx

# TASK 3
# create limits.yml

# Deploy it to the cluster with
kubectl apply -f limits.yaml -n projectx

# Check its status
kubectl describe limitrange -n projectx

# TASK 4
# Create a ResourceQuota for the namespace to set requests and limits both for CPU and memory (use values that you consider suitable). In addition, add limits for pods, services, deployments, and replicasets (again, use values that you find appropriate)

# Deploy the manifest to the cluster
kubectl apply -f quotas.yaml -n projectx

# check its status
kubectl describe quota -n project

# TASK 5
# Create a custom role (devguru) which will allow the one that has it to do anything with any of the following resources pods, services, deployments, and replicasets. Grant the role to ivan and mariana (or to the group they belong to) for the namespace created earlier

kubectl create role role-hw -n projectx --verb="*" --resource=pods,services,deployments.apps,replicasets.apps
kubectl describe role role-hw -n projectx

kubectl create rolebinding roleb-hw-ivan -n projectx --role role-hw --user ivan
kubectl create rolebinding roleb-hw-mariana -n projectx --role role-hw --user mariana

# check what we can do as ivan
kubectl auth can-i --list --namespace projectx --as ivan

kubectl create rolebinding roleb-hw-gurus -n projectx --role role-hw --group gurus

# check what we can do as ivan being a member of the gurus group
kubectl auth can-i --list --namespace projectx --as ivan --as-group gurus

# TASK 6
# Using one of the two users, deploy the producer-consumer application (use the attached files – you may need to modify them a bit). Deploy one additional pod that will act as a (curl) client

su ivan

kubectl apply -n projectx -f producer-deployment.yml
kubectl apply -n projectx -f producer-svc.yml
kubectl apply -n projectx -f consumer-deployment.yml
kubectl apply -n projectx -f consumer-svc.yml

# deploy a simple pod to act as a client for testing purposes
kubectl run client -n projectx --image alpine -- sleep 1d

# check how the deployment went
kubectl get pods,svc,rs,deployments -n projectx

# TASK 7
# Create one or more NetworkPolicy resources in order to
#   a. Allow communication to the producer only from the consumer
#   b. Allow communication to the consumer only from the client

kubectl exec -n projectx -it client -- s

apk update
apk add curl

curl http://consumer:5000
curl http://producer:5000

exit

kubectl apply -n projectx -f np-prod.yaml

kubectl apply -n projectx -f np-cons.yaml

kubectl exec -n projectx -it client - sh

curl --connect-timeout 5 http://consumer:5000

curl --connect-timeout 5 http://producer:5000