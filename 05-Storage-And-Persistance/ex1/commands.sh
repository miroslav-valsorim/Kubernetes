# The Docker Way

# For the usual example, we must create a ~/html folder
# There, we can create an index.html file

echo 'A simple <b>bind mount</b> test' | tee ~/html/index.html

# run a NGINX based container and mount the folder there
docker container run -d --name web -p 80:80 -v $(pwd)/html:/usr/share/nginx/html:ro nginx

curl http://localhost

docker container inspect web

docker container rm web --force

docker volume create demo

docker volume ls

docker volume inspect demo

echo 'A simple <b>volume</b> test' | sudo tee /var/lib/docker/volumes/demo/_data/index.html

docker container run -d --name web -p 80:80 -v demo:/usr/share/nginx/html:ro nginx

docker container run -d --name web -p 80:80 --mount source=demo,destination=/usr/share/nginx/html nginx

curl http://localhost

docker container inspect web

docker container rm web --force

docker volume rm demo

# Ephemeral Volumes

kubectl apply -f part1/emptydir-pod.yaml

kubectl apply -f part1/service.yaml

kubectl get pods,svc

kubectl describe pod pod-ed

kubectl exec -it pod-ed -- bash

ls -al /data

cat /data/notes.txt

exit

kubectl exec -it pod-ed -- /bin/bash -c "kill 1"

kubectl describe pod pod-ed

kubectl delete pod pod-ed

kubectl apply -f part1/emptydir-pod.yaml

kubectl describe pod pod-ed

kubectl delete pod pod-ed

# Git Repo

kubectl apply -f part1/git-pod.yaml

kubectl exec -it pod-git -- bash

kubectl delete pod pod-git

# Persistent Volumes

kubectl apply -f part1/hostpath-deployment.yaml

kubectl get pods -o wide

kubectl delete -f part1/hostpath-deployment.yaml

# NFS

echo 'nfs-server-ip nfs-server' | sudo tee -a /etc/hosts

sudo apt-get update && apt-get install -y nfs-common

chmod -R 777 /data/nfs/k8sdata

kubectl apply -f part1/nfs-deployment.yaml

kubectl get pods -o wide

# navigate to http://<cluster-node-ip>:30001/index.php

kubectl describe pod notes-deploy-<specific-id>

kubectl delete -f part1/nfs-deployment.yaml

# Persistent Volumes and Claims

kubectl apply -f part1/pvnfs10gb.yaml

kubectl get pv

kubectl describe pv pvnfs10gb

kubectl apply -f part1/pvc10gb.yaml

kubectl get pv

kubectl get pvc

kubectl describe pvc pvc10gb

kubectl apply -f part1/pv-deployment.yaml

kubectl get pods -o wide -w

kubectl describe pvc pvc10gb

kubectl describe pod notes-deploy-<specific-id>

kubectl delete -f part1/pvc10gb.yaml

kubectl apply -f part1/pvc10gb.yaml

kubectl apply -f part1/pv-deployment.yaml

kubectl scale --replicas=2 deployment notes-deploy

kubectl delete -f part1/pv-deployment.yaml

kubectl delete -f part1/service.yaml

kubectl delete -f part1/pvc10gb.yaml

kubectl delete -f part1/pvnfs10gb.yaml