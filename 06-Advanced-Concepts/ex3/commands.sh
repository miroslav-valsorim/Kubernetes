git clone https://github.com/nginxinc/kubernetes-ingress.git --branch v3.3.2

cd kubernetes-ingress/deployments

kubectl apply -f common/ns-and-sa.yaml

kubectl apply -f rbac/rbac.yaml

kubectl apply -f ../examples/shared-examples/default-server-secret/default-server-secret.yaml

kubectl apply -f common/nginx-config.yaml

kubectl apply -f common/ingress-class.yaml

kubectl apply -f common/crds/k8s.nginx.org_virtualservers.yaml

kubectl apply -f common/crds/k8s.nginx.org_virtualserverroutes.yaml

kubectl apply -f common/crds/k8s.nginx.org_transportservers.yaml

kubectl apply -f common/crds/k8s.nginx.org_policies.yaml

kubectl apply -f deployment/nginx-ingress.yaml

kubectl get pods --namespace=nginx-ingress -w

kubectl create -f service/nodeport.yaml

kubectl get service -n nginx-ingress

# HAProxy
# https://github.com/haproxytech/kubernetes-ingress