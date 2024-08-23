minikube start --driver=virtualbox --no-vtx-check --nodes=2

kubectl cluster-info

kubectl get nodes -o wide

kubectl apply -f homework.yaml

kubectl get pods,svc -n homework -o wide

minikube ip

# reach the application on http://<minikube-ip>:32000/

minikube service list

kubectl delete -f homework.yaml

minikube delete