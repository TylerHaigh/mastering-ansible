# Terraform Script to create AWS Servers

# Provider to AWS

variable "aws_access_key" {
  description = "AWS CLI Access Key for programmatic access to AWS APIs"
}

variable "aws_secret_key" {
  description = "AWS CLI Access Key's Secret for programmatic access to AWS APIs"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "ap-southeast-2"
}


# VPC

resource "aws_vpc" "ansible_vpc" {
  cidr_block = "10.0.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "Ansible VPC"
  }
}

# Subnets
# See http://blog.itsjustcode.net/blog/2017/11/18/terraform-cidrsubnet-deconstructed/ for a good writeup on
# how to split your VPC into subnets
# http://jodies.de/ipcalc?host=10.0.0.0&mask1=24&mask2=28

resource "aws_subnet" "az_a" {
  vpc_id = "${aws_vpc.ansible_vpc.id}"
  cidr_block = "${cidrsubnet("${aws_vpc.ansible_vpc.cidr_block}", 4, 0)}" #"10.0.0.0/28"
  availability_zone = "ap-southeast-2a"
  tags = {
    Name = "Ansible AZ A"
  }
}

resource "aws_subnet" "az_b" {
  vpc_id = "${aws_vpc.ansible_vpc.id}"
  cidr_block = "${cidrsubnet("${aws_vpc.ansible_vpc.cidr_block}", 4, 1)}" #"10.0.0.16/28"
  availability_zone = "ap-southeast-2b"
  tags = {
    Name = "Ansible AZ B"
  }
}


# SSH Keys for EC2 Access

# Provides an EC2 key pair resource. A key pair is used to control login access to EC2 instances.
# Currently this resource requires an existing user-supplied key pair.
# This key pair's public key will be registered with AWS to allow logging-in to EC2 instances.
# variable "ec2_key_pair_public_key_material" {
#   description = "Public Key material to create an EC2 Key Pair"
# }

resource "aws_key_pair" "ssh_key_access" {
  key_name = "AnsibleHost_v2"
  public_key = "${file("keys/AnsibleHost.pem.pub")}"
}


# Security Group to be applied to all EC2 Instances

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "ansible_security_group" {
  name = "Ansible Security Group V2"
  description = "Firewalls for Ansible Servers"
  vpc_id = "${aws_vpc.ansible_vpc.id}"

  tags {
    Name = "Ansible Security Group"
  }

  ingress {
    description = "SSH from Home IP"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "${chomp(data.http.myip.body)}/32" ]
  }

  ingress {
    description = "HTTP from Home IP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "${chomp(data.http.myip.body)}/32" ]
  }

  ingress {
    description = "HTTPS from Home IP"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "${chomp(data.http.myip.body)}/32" ]
  }

  ingress {
    description = "SSH from Internal IPs"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "${aws_vpc.ansible_vpc.cidr_block}" ]
  }

  # ingress {
  #   description = "SSH from Control Host Private IP"
  #   from_port = 22
  #   to_port = 22
  #   protocol = "tcp"
  #   cidr_blocks = [ "${aws_instance.control_host.private_ip}" ]
  # }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# EC2 Instances

resource "aws_instance" "control_host" {
  ami = "ami-02fd0b06f06d93dfc"
  availability_zone = "ap-southeast-2a"
  subnet_id = "${aws_subnet.az_a.id}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.ssh_key_access.key_name}"
  associate_public_ip_address = true

  security_groups = [ "${aws_security_group.ansible_security_group.id}" ]

  root_block_device {
    volume_type = "gp2"
    volume_size = 16 # GB
    iops = 100
    delete_on_termination = true
  }

  tags = {
    Name = "Ansible-ControlHost"
  }
}

resource "aws_instance" "web_server" {
  ami = "ami-02fd0b06f06d93dfc"
  availability_zone = "ap-southeast-2a"
  subnet_id = "${aws_subnet.az_a.id}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.ssh_key_access.key_name}"
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 16 # GB
    iops = 100
    delete_on_termination = true
  }

  security_groups = [ "${aws_security_group.ansible_security_group.id}" ]

  tags = {
    Name = "Ansible-WebServer"
  }
}

resource "aws_instance" "load_balancer" {
  ami = "ami-02fd0b06f06d93dfc"
  availability_zone = "ap-southeast-2a"
  subnet_id = "${aws_subnet.az_a.id}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.ssh_key_access.key_name}"
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 16 # GB
    iops = 100
    delete_on_termination = true
  }

  security_groups = [ "${aws_security_group.ansible_security_group.id}" ]

  tags = {
    Name = "Ansible-LoadBalancer"
  }
}

resource "aws_instance" "database" {
  ami = "ami-02fd0b06f06d93dfc"
  availability_zone = "ap-southeast-2a"
  subnet_id = "${aws_subnet.az_a.id}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.ssh_key_access.key_name}"
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 16 # GB
    iops = 100
    delete_on_termination = true
  }

  security_groups = [ "${aws_security_group.ansible_security_group.id}" ]

  tags = {
    Name = "Ansible-Database"
  }
}
