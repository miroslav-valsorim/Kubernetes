# Samples are either inspired and/or taken directly from here: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/

kubectl apply -f part1/1-liveness-cmd.yaml

kubectl describe pod liveness-cmd
# x2

kubectl get pod liveness-cmd

kubectl delete -f part1/1-liveness-cmd.yaml

kubectl apply -f part1/2-liveness-http.yaml

kubectl describe pod liveness-http

kubectl describe pod liveness-http

kubectl get pod liveness-http

kubectl delete -f part1/2-liveness-http.yaml

# Readiness Probes

kubectl apply -f part1/3-readiness-cmd.yaml

kubectl describe pod readiness-cmd

kubectl describe svc readiness-cmd

kubectl describe svc readiness-cmd

watch -n 2 kubectl get pods,svc -o wide

kubectl delete -f part1/3-readiness-cmd.yaml

# HTTP Probe

kubectl apply -f part1/4-readiness-http.yaml

kubectl describe pod readiness-http

kubectl describe svc readiness-http

kubectl describe svc readiness-http

watch -n 2 kubectl get pods,svc -o wide

kubectl delete -f part1/4-readiness-http.yaml

# Startup Probes

kubectl apply -f part1/5-startup-liveness-same.yaml

kubectl logs startup-same

kubectl describe pod startup-same

kubectl delete -f part1/5-startup-liveness-same.yaml

# Startup and Liveness Mixed Type

kubectl apply -f part1/6-startup-liveness-mixed.yaml

kubectl describe pod startup-mixed

kubectl describe svc startup-mixed

watch -n 2 kubectl get pods,svc -o wide

kubectl delete -f part1/6-startup-liveness-mixed.yaml