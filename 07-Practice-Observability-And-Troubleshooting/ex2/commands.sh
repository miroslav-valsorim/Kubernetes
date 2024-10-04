# Auditing

# Samples are either inspired and/or taken directly from here: 
# https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application-introspection/

sudo mkdir /var/lib/k8s-audit

sudo cp part2/1-audit-simple.yaml /var/lib/k8s-audit/

sudo mkdir /var/log/k8s-audit

sudo vi /etc/kubernetes/manifests/kube-apiserver.yaml

kubectl get pods -n kube-system -w

kubectl run logtest1 --image=alpine -- sleep 1d

kubectl get pods

cat /var/log/k8s-audit/audit.log | grep logtest1

cat /var/log/k8s-audit/audit.log | grep logtest1 | jq

cat /var/log/k8s-audit/audit.log | grep logtest1 | jq -s length

kubectl delete pod logtest1