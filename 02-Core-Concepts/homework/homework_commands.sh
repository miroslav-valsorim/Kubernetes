# first ex
minikube start --driver=virtualbox --no-vtx-check
kubectl create namespace homework
kubectl get namespaces
kubectl run homework-1 --image shekeriev/k8s-oracle -n homework --labels='app=hw,tier=gold'
kubectl kubectl label pods homework-1 tier- -n homework
kubectl get pod -n homework
kubectl describe pod homework-1 -n homework # check labels of pod homework-1 in namespace homework
kubectl label pods homework-1 tier- -n homework # delete label tier in pod homework-1
kubectl describe pod homework-1 -n homework # check labels of pod homework-1 in namespace homework
kubectl run homework-2 --image shekeriev/k8s-oracle -n homework
kubectl get pods -n homework
kubectl label pods homework-2 app=hw -n homework # create label for already made pod
kubectl describe pod homework-2 -n homework # check labels of pod homework-2 in namespace homework
kubectl annotate pods homework-1 purpose=homework -n homework
kubectl annotate pods homework-2 purpose=homework -n homework
kubectl create service nodeport homework-svc --tcp=5000:5000 --namespace=homework
minikube service list

# ex2 create the manifests for the above commands
kubectl create namespace homework --dry-run=client --output=yaml > separate-yamls/namespace.yaml
kubectl run homework-1 --image=shekeriev/k8s-oracle -n homework --labels=app=hw,tier=gold --dry-run=client --output=yaml > separate-yamls/pod-1.yaml
kubectl run homework-2 --image=shekeriev/k8s-oracle -n homework --labels=app=hw --dry-run=client --output=yaml > separate-yamls/pod-2.yaml
kubectl create service nodeport homework-svc --tcp=5000:5000 --namespace=homework --dry-run=client --output=yaml > separate-yamls/svc.yaml

# ex3 apply all commands from ex2 one by one
kubectl delete namespace homework
kubectl create -f separate-yamls/namespace.yaml
kubectl get namespaces
kubectl create -f separate-yamls/pod-1.yaml
kubectl create -f separate-yamls/pod-2.yaml
kubectl get pods -n homework
kubectl create -f separate-yamls/svc.yaml
minikube service list

# ex4 apply all manifests from ex2-ex3 at once
kubectl delete namespace homework
kubectl apply -f ./separate-yamls
