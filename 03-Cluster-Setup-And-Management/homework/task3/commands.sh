# setup vagrant

vagrant up

vagrant ssh node1

kubectl cluster-info

kubectl get nodes -o wide

kubectl apply -f /vagrant/homework.yaml

kubectl get pods,svc -n homework -o wide

curl http://192.168.99.101:32000

kubectl delete -f /vagrant/homework.yaml

exit

vagrant destroy --force