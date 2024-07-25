minikube status
minikube start --dry-run=true # start default driver and checks for other drivers available

minikube start --driver=virtualbox # failed Exiting due to HOST_VIRT_UNAVAILABLE: Failed to start host: creating host: create: precreate: This computer doesn't have VT-X/AMD-v enabled. Enabling it in the BIOS is mandatory
minikube start --no-vtx-check # fixed the error above

minikube start --driver=virtualbox --no-vtx-check # final command

minikube ssh
id
docker versioncls
docker image ls
docker container ls


kubectl api-resources
kubectl api-versions
kubectl explain pod
kubectl explain pod.spec
powershell
kubectl explain pod.spec | find.exe /I `"required`"
exit


kubectl create namespace ns1
kubectl get namespaces

kubectl create namespace ns2 --dry-run=client --output=yaml > ns2.yaml
kubectl create -f ns2.yaml
kubectl delete namespaces ns2

kubectl create -f ns2.yaml
kubectl delete -f ns2.yaml


kubectl get pods
kubectl get ns 
kubectl get pods --all-namespaces
kubectl get pods -A


kubectl run nginx-pod --image nginx
kubectl get pods
kubectl delete pod nginx-pod

kubectl run nginx-pod --image nginx -n ns1
kubectl run --help
kubectl options
kubectl get pods -A
kubectl get pods -n ns1

kubectl run nginx-pod-yaml --image nginx -n ns1 --dry-run=client -o=yaml

kubectl create -f demo-files/1-appa-pod.yml
kubectl get pods
kubectl describe pod appa-pod
# add labels 
kubectl apply -f demo-files/2-appa-pod-ext.yml
kubectl describe pod appa-pod
powershell
# compare both manifests
Compare-Object (Get-Content -Path demo-files/1-appa-pod.yml) -DifferenceObject (Get-Content -Path demo-files/2-appa-pod-ext.yml) -IncludeEqual
exit


kubectl run nginx-1 --image=nginx --labels="image=nginx,ver=v1" --annotations="created-by=user1"
kubectl run nginx-2 --image=nginx --labels="image=nginx,ver=v2" --annotations="created-by=user1"
kubectl get pods
kubectl get pods -o wide
kubectl get pods --show-labels
kubectl get pods -L image,ver
kubectl get pods -L app,image,ver
kubectl get pods -l ver=v1
kubectl get pods -l image=nginx
kubectl describe pod nginx-1
kubectl label --overwrite pods nginx-2 ver=v1
kubectl get pods --show-labels
kubectl delete pods -l image=nginx


kubectl get pods
kubectl expose pod appa-pod --name=appa-svc --target-port=80 --type=NodePort
kubectl get svc appa-svc
kubectl describe svc appa-svc
minikube service list
kubectl delete svc appa-svc
kubectl get svc
kubectl get pod
kubectl apply -f demo-files/3-appa-svc.yml
kubectl get svc
minikube service list
kubectl describe svc appa-svc
kubectl run appa-pod-1 --image=shekeriev/k8s-appa:v1 --labels="app=appa,ver=v1"
kubectl describe svc appa-svc
kubectl delete pod appa-pod
kubectl delete pod appa-pod-1
kubectl describe svc appa-svc


code demo-files/4-rc.yml # opens vs code with the current file set
kubectl apply -f demo-files/4-rc.yml
kubectl get rc
kubectl get rc -o wide
kubectl describe rc appa-rc
kubectl describe services appa-svc
kubectl get svc
kubectl get svc -o wide
kubectl get nodes
kubectl get nodes -w wide
minikube service list
kubectl scale --replicas=5 rc/appa-rc
kubectl get rc
kubectl get pods
kubectl describe services appa-svc
kubectl describe endpoints appa-svc
kubectl scale --replicas=2 rc/appa-rc
kubectl get rc
kubectl get pods
kubectl delete -f demo-files/4-rc.yml
kubectl get rc


kubectl apply -f demo-files/5-rs.ym
kubectl get rs
kubectl get rs -o wide
kubectl describe rs appa-rs
kubectl describe services appa-svc
minikube service list
kubectl scale --replicas=5 rs/appa-rs
kubectl get rs
kubectl describe services appa-svc
kubectl describe endpoints appa-sv
kubectl scale --replicas=2 rs/appa-rs
kubectl get rs
kubectl delete -f demo-files/5-rs.yml


kubectl create deployment appa-deploy --image=shekeriev/k8s-appa:v1 --replicas=2 --port=80
kubectl get deployments
kubectl describe deployment appa-deploy
kubectl scale deployment appa-deploy --replicas=10
kubectl get pods -w
kubectl get pods
kubectl get pods -o wide
kubectl delete deployment appa-deploy
kubectl get pods
kubectl apply -f demo-files/6-appa-deploy-v1.yml
kubectl get pods -w
kubectl get deployments
kubectl get deployments -o wide
powershell
Compare-Object (Get-Content -Path demo-files/6-appa-deploy-v1.yml) -DifferenceObject (Get-Content -Path demo-files/7-appa-deploy-v2.yml) -IncludeEqual
exit
kubectl apply -f demo-files/7-appa-deploy-v2.yml
kubectl rollout status deployment appa-deploy
kubectl rollout history deployment appa-deploy
kubectl rollout undo deployment appa-deploy --to-revision=1
kubectl rollout status deployment appa-deploy
kubectl rollout history deployment appa-deploy
kubectl delete deployment appa-deploy
kubectl delete service appa-svc
kubectl get all --all-namespaceseee