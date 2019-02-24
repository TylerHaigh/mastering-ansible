# Terraform Scripts #

This will create the required AWS Infrastructure to use as target remote Ansible Servers

## Steps ##

### 1. Create an SSH Key ###

From the EC2 Console, create an SSH Key Pair called `AnsibleHost` and download the .pem file to your local machine.
Keep this handy because you will use this to SSH into the VMs


### 2. Create Infrastructure ###

Run `terraform apply` to create the infrastructure

### 3. Configure your ansible host ###

* Upload the `AnsibleHost.pem` file to the Ansible Control Server
* Configure the SSH Config settings as per `ssh.config.example` - This will let you (and ansible) SSH into the remote servers

