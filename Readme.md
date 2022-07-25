
## Deploy Nginx Docker terraform

This project demonstrates the provisioning of ngnix docker container using Docker as s provisional

### Pre-requisite
Install terraform v1.0.0
Setup the aws cli credentials with default profile name.

### Setup
Create and run the provider.tf
 ### Then create the resource aws_key_pair 
 resource "aws_key_pair" "terraform-demo" {)
 
 then create the aws_instance
 resource "aws_instance" "mydocker-server" {)
 
### create the security group
resource "aws_security_group" "docker_connect" {)

### Create the install.docker.sh bash file below that willinstall the docker and run the container withe image nginx:alpine

#! /bin/sh

  yum update -y
  
  yum install docker -y
  
  service docker start
  
  docker pull nginx:alpine
  
  docker run -it -d --name my-docker-container -p 80:80 nginx:alpine

URL to access the web server.

Run docker build
