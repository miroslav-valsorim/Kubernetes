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