kubectl apply -f part3/pvssa.yaml

kubectl apply -f part3/pvssb.yaml

kubectl apply -f part3/pvssc.yaml

kubectl get pv

kubectl apply -f part3/svcss.yaml

kubectl get svc

kubectl apply -f part3/ss.yaml

kubectl get pod,svc,statefulset,pv,pvc

kubectl apply -f part3/svcssnp.yaml

kubectl get pod,svc,statefulset,pv,pvc

kubectl get pods,pvc -o wide

kubectl delete pod facts-0

kubect get pods,pvc -o wide

kubectl scale --replicas=1 statefulset/facts

ubectl get pod,svc,statefulset,pv,pvc

ubectl scale --replicas=3 statefulset/facts

kubectl get pod,svc,statefulset,pv,pvc

kubectl delete statefulset.apps/facts

kubectl delete service/facts service/factsnp

kubectl delete persistentvolumeclaim facts-data-facts-0 facts-data-facts-1 facts-data-facts-2

kubectl delete persistentvolume pvssa pvssb pvssc