docker container run -d -p 80:80 --name var --env DEMO_VAR="Hello Envrironment" shekeriev/k8s-environ

docker container rm var --force

docker container run -d -p 80:80 --name var --env XYZ1=VALUE1 --env XYZ2=42 shekeriev/k8s-environ

docker container rm var --force

export XYZ1=VALUE1

export XYZ2=42

docker container rm var --force

cat > env.list << EOF
XYZ1=NEWVALUE
XYZ2
XYZ3
XYZ4="Another variable and its value"
EO

docker container run -d -p 80:80 --name var --env-file env.list shekeriev/k8s-environ

docker container rm var --force

docker container run -d -p 80:80 --name var --env-file env.list --env FOCUSON=XYZ shekeriev/k8s-environ

docker container rm var --force

kubectl apply -f part2/pod-no-env.yaml

kubectl apply -f part2/svc-environ.yaml

kubectl get pods,svc

kubectl describe pod pod-no-env

kubectl delete -f part2/pod-no-env.yaml

kubectl apply -f part2/pod-w-env.yaml

kubectl describe pod pod-w-env

kubectl delete -f part2/pod-w-env.yaml