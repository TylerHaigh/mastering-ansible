# Creating Ansible Hosts #

From AWS EC2 Dashboard, create 4 ec2 instanes. You can create one configuration and deploy it 4 times:

* Control Host
* Web Server
* Load Balancer
* Database

## EC2 Server Settings ##

* AMI: Amazon Linux AMI 2018.03.0 (HVM), SSD Volume Type  (yum based package manager)
    * Make sure to enable epel repo to allow installation of ansible
    * `sudo yum-config-manager --enable epel`
* Size: T2-Micro
* 16GB EBS Volume

## Security Groups ##

| Type  | Protocol | Port Range | Source            | Description     |
| ----- | -------- | ---------- | ----------------- | --------------- |
| SSH   | TCP      | 22         | 116.240.45.203/32 | Home IP         |
| SSH   | TCP      | 22         | 52.62.189.139/32  | Control Public  |
| SSH   | TCP      | 22         | 172.31.4.102/32   | Control Private |
| HTTP  | TCP      | 80         | 116.240.45.203/32 | HTTP Access     |
| HTTPS | TCP      | 443        | 116.240.45.203/32 | HTTPS Access    |

# Configuring ansible.cfg #

When running from windows subsystem, you may get the following error:

>  [WARNING] Ansible is being run in a world writable directory (/mnt/d/Projects/Ansible/mastering-ansible/2_foundation), ignoring it as an ansible.cfg source. For more information see https://docs.ansible.com/ansible/devel/reference_appendices/config.html#cfg-in-world-writable-dir

You need to run the following command before running any ansible tasks

```
export ANSIBLE_CONFIG=./ansible.cfg
```

This will bypass the error.

# Using Vagrant within Windows Subsystem for Linux #

Vagrant will not operate outside the Windows Subsystem for Linux unless explicitly
instructed. To do this, run the following command

```
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
```

You need to ensure that Vagrant is installed on both Windows and WSL. The Vagrant available in Ubuntu's Apt repo is out of sync, so you will need to `wget` the latest `debian` package and run `sudo dpkg -i` to install it:

```
wget https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.deb
sudo dpkg -i vagrant_2.2.4_x86_64.deb
```

Vagrant will want to use VirtualBox by default. If you are running Windows 10 Professional with HyperV Enabled (usually for running Docker natively), VirtualBox will be disabled. You need to configure Vagrant to run using HyperV. You also need to run the WSL `bash` terminal from an Administerator terminal:

1. Run powershell (or cmd) as Admin
2. RUn `bash` to enter the WSL

Now Vagrant can use HyperV


# Changing Vagrant VMs #

If you destroy and recreate your Vagrant VMs, you may get the following message from Ansible

```
Failed to connect to the host via ssh:
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the RSA key sent by the remote host is
SHA256:U/eNuEQIhYuL8cdFb1EUyKKceY5PlS32gJeHGJ0NKDU.
Please contact your system administrator.
Add correct host key in /home/your_user_name/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /home/your_user_name/.ssh/known_hosts:19
  remove with:
  ssh-keygen -f "/home/your_user_name/.ssh/known_hosts" -R "192.168.60.6"
RSA host key for 192.168.60.6 has changed and you have requested strict checking.
Host key verification failed.
```

Run the prescribed command to remove it

```
ssh-keygen -f "/home/your_user_name/.ssh/known_hosts" -R "192.168.60.6"
```

# SSH Into Vagrant Machine #

Run the following command:

```
# To ssh into 192.168.60.7 (Load Balancer)
ssh -i ~/.vagrant.d/insecure_private_key vagrant@192.168.60.7
```