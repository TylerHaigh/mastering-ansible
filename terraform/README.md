# Terraform Scripts #

This will create the required AWS Infrastructure to use as target remote Ansible Servers

## Steps ##

### 1. Create an SSH Key ###

Run the following command to create an SSH Key:

```
ssh-keygen -t rsa -C "Ansible Host SSH Key" -f keys/AnsibleHost.pem
```