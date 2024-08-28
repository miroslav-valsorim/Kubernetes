# continue with the setup from ex1

kubectl describe nodes

kubectl create namespace reslim

# Unrestricted Pods

kubectl run pod-1 --image=alpine --restart=Never --namespace reslim -- dd if=/dev/zero of=/dev/null bs=16M

kubectl get pods -n reslim -o wide

kubectl describe node node2

kubectl exec -it pod-1 -n reslim -- top

kubectl delete pod pod-1 -n reslim

# Resource Requests

kubectl apply -f part2/pod-2.yaml

kubectl get pods -n reslim -o wide

kubectl exec -it pod-2 -n reslim -- top

kubectl describe node node2

kubectl apply -f part2/deployment-res.yaml

kubectl get pods -n reslim -o wide

kubectl describe node node2

kubectl scale deployment res -n reslim --replicas=5

kubectl get deployment -n reslim

kubectl get pods -n reslim -o wide

kubectl describe pod <pod-id> -n reslim

kubectl delete -f part2/deployment-res.yaml

kubectl delete -f part2/pod-2.yaml

# Resource Limits

kubectl apply -f part2/pod-3a.yaml

kubectl get pods -n reslim -o wide

kubectl describe node node3

kubectl exec -it pod-3a -n reslim -- top

kubectl delete pod pod-3a -n reslim

kubectl apply -f part2/pod-3b.yaml

kubectl get pods -n reslim -o wide -w

kubectl delete -f part2/pod-3b.yaml

# Limit Ranges

kubectl apply -f part2/limits.yaml

kubectl describe limitrange limits -n reslim

kubectl apply -f part2/pod-4a.yaml

kubectl apply -f part2/pod-4b.yaml

kubectl apply -f part2/pod-4c.yaml

kubectl delete pod pod-4a -n reslim

kubectl delete -f part2/limits.yaml

# Quotas

kubectl apply -f part2/quota.yaml

kubectl get quota -n reslim

kubectl describe quota quota -n reslim

kubectl apply -f part2/pod-5a.yaml

kubectl apply -f part2/pod-5b.yaml

kubectl describe quota quota -n reslim

kubectl delete namespace reslim