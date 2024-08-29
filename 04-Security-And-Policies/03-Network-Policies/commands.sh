# install network plugin

kubectl create namespace basicnp

kubectl create deployment oracle --image=shekeriev/k8s-oracle --namespace basicnp

kubectl expose deployment oracle --port=5000 --namespace basicnp

kubectl get svc,pod -n basicnp

kubectl run tester --image=alpine --namespace basicnp -- sleep 1d

kubectl exec -it tester --namespace basicnp -- sh

apk add curl

curl --connect-timeout 5 http://oracle:5000

exit

kubectl apply -f part3/oracle-policy.yaml

kubectl describe netpol access-oracle -n basicnp

kubectl exec -it tester --namespace basicnp -- sh

curl --connect-timeout 5 http://oracle:5000

exit

kubectl run tester --image=alpine -- sleep 1d

kubectl exec -it tester -- sh

apk add curl

curl --connect-timeout 5 http://oracle.basicnp:5000

exit

kubectl label pods tester --namespace basicnp access=true

kubectl exec -it tester --namespace basicnp -- sh

curl --connect-timeout 5 http://oracle:5000

exit

kubectl exec -it tester -- sh

curl --connect-timeout 5 http://oracle.basicnp:5000

exit

kubectl label pods tester access=true

kubectl exec -it tester -- sh

curl --connect-timeout 5 http://oracle.basicnp:5000

exit

kubectl edit netpol access-oracle -n basicnp

- namespaceSelector: {}

kubectl exec -it tester -- sh

curl --connect-timeout 5 http://oracle.basicnp:5000

exit

kubectl label pod tester access-

kubectl exec -it tester -- sh

curl --connect-timeout 5 http://oracle.basicnp:5000

exit

kubectl describe netpol access-oracle -n basicnp

kubectl edit netpol access-oracle -n basicnp

kubectl describe netpol access-oracle -n basicnp

kubectl delete pod tester

kubectl delete namespace basicnp

kubectl create -f https://docs.tigera.io/files/00-namespace.yaml
kubectl create -f https://docs.tigera.io/files/01-management-ui.yaml
kubectl create -f https://docs.tigera.io/files/02-backend.yaml
kubectl create -f https://docs.tigera.io/files/03-frontend.yaml
kubectl create -f https://docs.tigera.io/files/04-client.yaml

kubectl get pods --all-namespaces --watch

kubectl get all -n management-ui

kubectl create -n stars -f https://docs.tigera.io/files/default-deny.yaml

kubectl create -n client -f https://docs.tigera.io/files/default-deny.yaml

kubectl create -f https://docs.tigera.io/files/allow-ui.yaml

kubectl create -f https://docs.tigera.io/files/allow-ui-client.yaml

kubectl create -f https://docs.tigera.io/files/backend-policy.yaml

kubectl create -f https://docs.tigera.io/files/frontend-policy.yaml

kubectl delete ns client stars management-ui