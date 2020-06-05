provider "aws" {
  region = "us-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_key_pair" "k8s-key" {
  key_name   = "k8s-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnWNwGRVEivd269B9B7QZ/g/eRwbwuC+c3GDMNc1Gpmw810hYO9n1iMqR27azxFyjSPIpiADKBf8yI/dt6tkQGW3KzgriBc4T/4qNLVMIQ2fr881N7i3fbsv0VIw+qHqyl2rGgDHhhe7gJBaefItPdEfpGcfVPknckwrumNG1R2+VileiN2it6kKxQRMW6o0HBNuNY738A9nncpgzU3qnFfy9MF5Vs7o3eYaQOKaqbpdVbSD2MLGZrXlnrgY7L3EUOiGJMBy/Bw4p0GhoznakPg1ckFAiXwJw3hr7CLlNOTmoKhd1vo5wEsYpmChTvlHxn7UnbS4UbwblL/5QT44fIt1lgduwmePsZxBDtKzjS4XhII0lud3B6FMqPgsJpyOy6/Bx/QJvi780s2/SlAyIYZlcr6YN65a9hSlqk61KunhjNKMOZz6/rymyeYcZDIxurDUbA21tshm85Z/+6BZiN2PiDYUvJ7p8e/EF47PWvbVIy84kPN70xEFP9kQI5+Gs= mateus@ubuntu-19"
}

resource "aws_security_group" "k8s-sg" {
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

} 

resource "aws_instance" "kubernetes" {
  ami           = "ami-085925f297f89fce1"
  instance_type = "t3.medium"
  key_name = "k8s-key"
  count = 3
  tags = {
    name = "k8s"
  }
  security_groups = ["${aws_security_group.k8s-sg.name}"]
}

