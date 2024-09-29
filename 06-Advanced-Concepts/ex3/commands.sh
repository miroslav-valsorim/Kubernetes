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

kubectl apply -f https://raw.githubusercontent.com/haproxytech/kubernetes-ingress/master/deploy/haproxy-ingress.yaml

apiVersion: networking.k8s.io/v1

# kind: IngressClass
# metadata:
#     name: haproxy
# spec:
#     controller: haproxy.org/ingress-controller

kubectl apply -f haproxy-class.yaml

kubectl get ingressclass

# Ingress

kubectl apply -f part3/pod-svc-1.yaml

kubectl get pod,svc

kubectl apply -f part3/1-nginx-single.yaml

kubectl get ingress

kubectl describe ingress ingress-ctrl

kubectl get svc nginx-ingress -n nginx-ingress

kubectl get svc haproxy-kubernetes-ingress -n haproxy-controller

# Single Service with Custom Path

kubectl apply -f part3/2-nginx-custom-path-a.yaml

kubectl describe ingress ingress-ctrl

# Open a browser tab and navigate to http://demo.lab:<node-port>/service1

kubectl logs pod1

#"GET /service1 HTTP/1.1" 404

kubectl apply -f part3/2-nginx-custom-path-b.yaml

kubectl describe ingress ingress-ctrl

# Open a browser tab and navigate to http://demo.lab:<node-port>/service1

# Default Backend

kubectl apply -f part3/pod-svc-d.yaml

kubectl apply -f part3/3-nginx-default-back.yaml

kubectl describe ingress ingress-ctrl

# Open a browser tab and navigate to http://demo.lab:<node-port>
# Ha, it is working and showing different output (the default one) 
# Now, check the previous URL - http://demo.lab:<node-port>/service1

# Fan Out

kubectl apply -f part3/pod-svc-2.yaml

kubectl apply -f part3/4-nginx-fan-out.yaml

kubectl describe ingress ingress-ctrl

# Open a browser tab and navigate to http://demo.lab:<node-port> 
# Now, check the service1 URL - http://demo.lab:<node-port>/service1 
# And finally, check the service2 URL - http://demo.lab:<node-port>/service2

# Name Based Virtual Hosting

kubectl apply -f part3/5-nginx-name-vhost.yaml

kubectl describe ingress ingress-ctrl

# clean up

kubectl delete pods podd pod1 pod2

kubectl delete svc serviced service1 service2

kubectl delete ingress ingress-ctrl

kubectl delete namespace nginx-ingress

kubectl delete clusterrolebinding nginx-ingress

kubectl delete clusterrole nginx-ingress

kubectl delete -f common/crds/

kubectl delete -f https://raw.githubusercontent.com/haproxytech/kubernetes-ingress/master/deploy/haproxy-ingress.yaml
