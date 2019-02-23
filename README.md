# Creating Ansible Hosts #

From AWS EC2 Dashboard, create 4 ec2 instanes:

* Control Host
* Web Server
* Load Balancer
* Database

## EC2 Server Settings ##

* AMI: Amazon Linux AMI 2018.03.0 (HVM), SSD Volume Type  (yum based package manager)
* Size: T2-Micro
* 16GB EBS Volume

## Security Groups ##

| Type | Protocol | Port Range | Source            | Description     |
| ---- | -------- | ---------- | ----------------- | --------------- |
| SSH  | TCP      | 22         | 116.240.45.203/32 | Home IP         |
| SSH  | TCP      | 22         | 52.62.189.139/32  | Control Public  |
| SSH  | TCP      | 22         | 172.31.4.102/32   | Control Private |


# Configuring ansible.cfg #

When running from windows subsystem, you may get the following error:

>  [WARNING] Ansible is being run in a world writable directory (/mnt/d/Projects/Ansible/mastering-ansible/2_foundation), ignoring it as an ansible.cfg source. For more information see https://docs.ansible.com/ansible/devel/reference_appendices/config.html#cfg-in-world-writable-dir

You need to run the following command before running any ansible tasks

```
export ANSIBLE_CONFIG=./ansible.cfg
```

This will bypass the error.