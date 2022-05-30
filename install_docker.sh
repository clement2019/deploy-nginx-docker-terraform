#! /bin/sh
  yum update -y
  yum install docker -y
  service docker start
  docker pull nginx:alpine
  docker run -it -d --name my-docker-container -p 80:80 nginx:alpine