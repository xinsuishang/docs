#!/bin/bash  
echo "----start----"
echo "----yum update----"
yum update
mkdir /download && cd /download

echo "----install wget----"
yum install -y wget
echo "----install lib----"
yum -y install gcc gcc-c++ openssl openssl-devel pcre pcre-devel zlib zlib-devel
echo "----install git----"
yum -y install git
echo "----install nginx----"
yum -y install nginx

echo "set completion-ignore-case on" >> /etc/inputrc

echo "----install docker----"
yum -y install docker

echo "----docker run----"
service docker start
docker volume create portainer_data
docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer