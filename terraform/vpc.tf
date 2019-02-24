# VPC

resource "aws_vpc" "ansible_vpc" {
  cidr_block = "10.0.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "Ansible VPC"
  }
}


# Internet Gateway

resource "aws_internet_gateway" "ansible_internet_gateway" {
  vpc_id = "${aws_vpc.ansible_vpc.id}"
  tags {
      Name = "ansible_internet_gateway"
    }
}

# Route Tables for IG

resource "aws_route_table" "ansible_ig_route_table" {
  vpc_id = "${aws_vpc.ansible_vpc.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.ansible_internet_gateway.id}"
    }
  tags {
      Name = "Ansible IG Route Table"
    }
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = "${aws_subnet.az_a.id}"
  route_table_id = "${aws_route_table.ansible_ig_route_table.id}"
}