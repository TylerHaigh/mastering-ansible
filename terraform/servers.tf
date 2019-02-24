# Terraform Script to create AWS Servers

# SSH Keys for EC2 Access

# You'll need to upload this manually to AWS. See README.md file
# resource "aws_key_pair" "ssh_key_access" {
#   key_name = "AnsibleHost_v2"
#   public_key = "${file("keys/AnsibleHost.pem.pub")}"
# }

# EC2 Instances

resource "aws_instance" "control_host" {
  ami = "ami-02fd0b06f06d93dfc"
  availability_zone = "ap-southeast-2a"
  subnet_id = "${aws_subnet.az_a.id}"
  instance_type = "t2.micro"
  key_name = "AnsibleHost"
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
  key_name = "AnsibleHost"
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
  key_name = "AnsibleHost"
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
  key_name = "AnsibleHost"
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
