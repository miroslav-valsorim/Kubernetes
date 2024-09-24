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

kubectl get nodes --show-labels

kubectl describe node k8s1

kubectl describe node | grep Taints

kubectl taint nodes k8s1 node-role.kubernetes.io/master:NoSchedule-

kubectl get pods -n kube-system -o wide

kubectl describe pod etcd-k8s1 -n kube-system

kubectl describe pod coredns-<identifier> -n kube-system

kubectl taint node k8s2 demo-taint=nomorework:NoSchedule

kubectl describe node | grep Taints

kubectl apply -f part2/2-schedule.yaml

kubectl get pods -o wide

kubectl delete -f part2/2-schedule.yaml

kubectl apply -f part2/2-schedule-toleration.yaml

kubectl get pods -o wide

kubectl taint node k8s2 demo-taint-

kubectl delete -f part2/2-schedule-toleration.yaml

kubectl apply -f part2/3-daemon-set.yaml

kubectl get ds

kubectl get pods

kubectl get nodes

kubectl get nodes --show-labels

kubectl label node k8s2 disk=samsung

kubectl get pods -o wide

kubectl get ds

kubectl get pods -o wide

kubectl get ds

kubectl label node k8s2 disk=wdc --overwrite

kubectl get pods -o wide

kubectl get ds

kubectl delete -f part2/3-daemon-set.yaml

kubectl apply -f part2/4-batch-job.yaml

kubectl get jobs

kubectl get jobs -o wide

kubectl get pods

kubectl describe job batch-job

kubectl describe pod batch-job

kubectl get jobs

kubectl delete -f part2/4-batch-job.yaml

kubectl apply -f part2/4-batch-job-serial.yaml

kubectl get jobs

kubectl describe job batch-job-serial

kubectl get pods

kubectl delete -f part2/4-batch-job-serial.yaml

kubectl apply -f part2/4-batch-job-parallel.yaml

kubectl get jobs

kubectl describe job batch-job-parallel

kubectl get pods -o wide

kubectl delete -f part2/4-batch-job-parallel.yaml

kubectl apply -f part2/4-batch-job-cron.yaml

kubectl get cronjobs

kubectl get cronjobs -o wide

kubectl get pods -o wide

kubectl delete -f part2/4-batch-job-cron.yaml