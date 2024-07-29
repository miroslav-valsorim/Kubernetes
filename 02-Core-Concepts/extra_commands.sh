kubectl apply -f demo-files-extra/producer-pod.yml
kubectl apply -f demo-files-extra/producer-svc.yml
kubectl apply -f demo-files-extra/observer-pod.yml
kubectl exec -it observer-pod -- sh # open the pod inside
apk add curl
curl http://producer:5000
curl http://producer.default:5000
curl http://producer.default.svc.cluster.local:5000
exit
kubectl delete -f demo-files-extra/producer-pod.yml

kubectl apply -f demo-files-extra/producer-deployment.yml # deployment
kubectl get pods
kubectl exec -it observer-pod -- sh # open the pod inside
exit
curl http://producer:5000
kubectl apply -f demo-files-extra/consumer-pod.ym
kubectl get pods
kubectl apply -f demo-files-extra/consumer-svc.yml
kubectl get svc
kubectl get pods,services
minikube service list
kubectl delete -f demo-files-extra/consumer-pod.yml
kubectl apply -f demo-files-extra/consumer-deployment.yml
minikube service list

kubectl delete -f demo-files-extra/observer-pod.yml
kubectl delete -f demo-files-extra/producer-deployment.yml
kubectl delete -f demo-files-extra/producer-svc.yml
kubectl delete -f demo-files-extra/consumer-deployment.yml
kubectl delete -f demo-files-extra/consumer-svc.yml
kubectl get all

minikube delete