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

  # 116.240.45.203
  # chomp(data.http.myip.body)

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
    description = "HTTP Alternate from Home IP"
    from_port = 8080
    to_port = 8080
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

  ingress {
    description = "HTTP from Internal IPs"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "${aws_vpc.ansible_vpc.cidr_block}" ]
  }

  ingress {
    description = "HTTPS from Internal IPs"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "${aws_vpc.ansible_vpc.cidr_block}" ]
  }

  ingress {
    description = "HTTP Alternate from Internal IPs"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [ "${aws_vpc.ansible_vpc.cidr_block}" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}