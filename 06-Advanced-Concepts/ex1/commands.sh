ps ax | grep /usr/bin/kubelet

cat /var/lib/kubelet/config.yaml

staticPodPath: /etc/kubernetes/manifests

grep static /var/lib/kubelet/config.yaml

ls -l /etc/kubernetes/manifests

sudo cat /etc/kubernetes/manifests/etcd.yam

sudo cp part1/1-static-pod.yaml /etc/kubernetes/manifests/

kubectl get pods -o wide

kubectl delete pod static-pod-<node-name>

kubectl get pods -o wide

sudo crictl --runtime-endpoint unix:///run/containerd/containerd.sock ps | grep static-pod

sudo crictl --runtime-endpoint unix:///run/containerd/containerd.sock rm --force <cont-id>

sudo crictl --runtime-endpoint unix:///run/containerd/containerd.sock ps | grep static-pod

kubectl get pods -o wide

sudo rm /etc/kubernetes/manifests/1-static-pod.yaml

kubectl get pods -o wide -w

kubectl apply -f part1/2-sidecar.yaml

kubectl get pods -o wide -w

kubectl get pods,svc -o wide

# http://<cluster-node-ip>:30001

kubectl describe pod/sidecar-<identifier>

kubectl exec -it pod/sidecar-<identifier> -c cont-sidecar -- sh

kubectl exec -it deploy/sidecar -c cont-sidecar -- sh

ls -al /data

cat /data/generated-data.txt

kubectl exec -it pod/sidecar-<identifier> -c cont-main -- kill 1

kubectl get pods

kubectl delete -f part1/2-sidecar.yaml

kubectl apply -f part1/3-adapter.yaml

kubectl get pods

kubectl exec -it adapter -c cont-main -- cat /var/log/app.log

kubectl exec -it adapter -c cont-adapter -- cat /var/log/out.log

kubectl delete -f part1/3-adapter.yaml

kubectl apply -f part1/4-init-container.yaml

kubectl get pods,svc

kubectl get pods -w

kubectl describe pod pod-init

kubectl delete -f part1/4-init-container.yaml