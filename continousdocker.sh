#!/usr/bin/env bash
set -e
 
echo '>>> Get old container id'
CID=$(sudo docker ps | grep "erwasambo/africachronicles" | awk '{print $1}')
echo $CID
 
echo '>>> Pulling newly built image from repository'
sudo docker pull erwasambo/africachronicles:latest 
 
echo '>>> Tagging new image'
NEW=$(sudo docker ps -a -q | head -n 1)
sudo docker commit $NEW erwasambo/africachronicles
 
 
echo '>>> Stopping old container'
if [ "$CID" != "" ];
then
  sudo docker stop $CID
fi
 
 
echo '>>> Restarting docker'
sudo service docker.io restart
sleep 5
 
 
echo '>>> Starting new container'
sudo docker run -d -p 80:80 -p 3306:3306 erwasambo/africachronicles /usr/bin/supervisord --nodaemon
 
 
echo '>>> Cleaning up containers'
sudo docker ps -a | grep "Exit" | awk '{print $1}' | while read -r id ; do
  sudo docker rm $id
done
 
 
echo '>>> Cleaning up images'
sudo docker images | grep "^<none>" | head -n 1 | awk 'BEGIN { FS = "[ \t]+" } { print $3 }'  | while read -r id ; do
  sudo docker rmi $id
done
