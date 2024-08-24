# setup kind locally 

# make sure Docker is working, if not start it

kind create cluster --name hw --config kind-cluster.yaml

kubectl config use-context kind-hw

kubectl cluster-info

kubectl get nodes -o wide

kubectl apply -f homework.yaml

kubectl get pods,svc -n homework -o wide

kubectl delete -f homework.yaml

kind delete cluster --name hw