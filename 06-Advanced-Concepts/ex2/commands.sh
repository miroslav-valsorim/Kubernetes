minikube addons enable metrics-server

wget https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml -O metrics-server.yaml

--kubelet-insecure-tls

kubectl apply -f metrics-server.yaml

kubectl apply -f part2/1-auto-scale.yaml

kubectl get pods

kubectl apply -f part2/1-auto-scale-hpa.yaml

kubectl get horizontalpodautoscalers auto-scale-deploy

kubectl get horizontalpodautoscalers auto-scale-deploy -o yaml

kubectl get pods -o wide

kubectl get deployments

watch -n 1 kubectl get hpa,deployment

kubectl run -it --rm --restart=Never load-generator --image=busybox -- sh -c "while true; do wget -O - -q http://auto-scale-svc.default; done"

kubectl get deployments

kubectl delete -f part2/1-auto-scale-hpa.yaml

kubectl delete -f part2/1-auto-scale.yaml

minikube addons disable metrics-server

kubectl delete -f metrics-server.yaml