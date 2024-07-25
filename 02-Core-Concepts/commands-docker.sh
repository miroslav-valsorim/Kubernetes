docker container run --name alp1 -it alpine sh
ls
ps
uname -a
apk update
apk add tree
tree
cat /etc/os-release
exit

docker container ls
docker container ls -a

docker container rm alp1
docker container ls -a

docker container run --name alp1 -it --rm alpine sh
pwd
ps
# 'ctr+p' + 'ctr+q' gets out of the container session without closing it
docker container ls
docker container attach alp1 # getting inside the container again
exit

docker container run --name web1 -d nginx
docker container ls
curl http://localhost # fails
docker container rm --force web1

docker run --name web1 -d -p 80:80 nginx # with open ports now
curl http://localhost # now it works
docker container ls
docker container rm --force web1

