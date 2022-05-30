terraform {

  #required_version = "~> 1.1.4"
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"

    }
  }

}

provider "aws" {
  profile = "myaws"
  region  = var.region

}


resource "aws_key_pair" "terraform-demo" {
  key_name   = "terraform-demo"
  public_key = "file(terraform_ec2_key.pub)"
}

resource "aws_instance" "mydocker-server" {
  ami           = var.ami
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.docker_connect.id}"]
  key_name               = "${aws_key_pair.terraform-demo.key_name}"

  user_data = file("install_docker.sh")

  tags = {
    Name  = "docker_Terraform"
    Batch = "5AM"
  }
}

resource "aws_security_group" "docker_connect" {
  name        = "docker_connect"
  description = "Allow ssh and http traffic"


  ingress {

    from_port = 22 # By default, the windows server listens on TCP port 22 for ssh
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {

    from_port = 80 #  By default, the windows server listens on TCP port 80 for http
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
}