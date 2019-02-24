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