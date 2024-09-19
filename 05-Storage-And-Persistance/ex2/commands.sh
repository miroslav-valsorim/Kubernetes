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


kubectl create configmap environ-map-a --from-literal=XYZ1=VALUE1

kubectl get cm

kubectl describe cm environ-map-a

kubectl get cm environ-map-a -o yaml

kubectl create configmap environ-map-b --from-literal=XYZ2=42 --from-literal=XYZ3=3.14

kubectl get cm

kubectl delete cm environ-map-a environ-map-b

kubectl apply -f part2/cm.yaml

kubectl get cm

cat > variables.conf << EOF
XYZ_FF1=VALUE1
XYZ_FF2=42
EO

kubectl create configmap environ-map-a --from-file=variables.conf

kubectl get cm

kubectl get cm environ-map-a -o yaml

cat > flag.conf << EOF
true
EOF

kubectl create configmap environ-map-b --from-file=debug=flag.conf

kubectl get cm

kubectl get cm environ-map-b -o yaml

kubectl delete cm environ-map-a environ-map-b

rm variables.conf flag.conf

mkdir variables

echo 'production' > variables/mode

echo 'false' > variables/debug

kubectl create configmap environ-map-a --from-file=variables/

kubectl get cm

kubectl get cm environ-map-a -o yaml

kubectl delete cm environ-map-a

rm -rf variables/

kubectl apply -f part2/pod-cm-env-var.yaml

kubectl delete pod pod-cm-env-var

kubectl apply -f part2/pod-cm-env-vars.yaml

kubectl apply -f part2/pod-cm-env-vars.yaml

kubectl get secret

kubectl describe secret

kubectl get secret -o yaml

kubectl create secret generic secret-a --from-literal=password='Parolka1'

echo 'DrugaParolka1' > password.conf

kubectl create secret generic secret-b --from-file=password=password.conf

kubectl get secret

kubectl get secret secret-a -o yaml

kubectl get secret secret-b -o yaml

echo <encoded-text> | base64 --decode

kubectl delete secret secret-a secret-b

kubectl apply -f part2/secrets.yaml

kubectl get secrets

kubectl apply -f part2/pod-secret.yaml

kubectl delete pod/pod-secret service/svc-environ secret/mysecrets

rm password.conf