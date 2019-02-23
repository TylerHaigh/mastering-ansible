# Configuring ansible.cfg #

When running from windows subsystem, you may get the following error:

>  [WARNING] Ansible is being run in a world writable directory (/mnt/d/Projects/Ansible/mastering-ansible/2_foundation), ignoring it as an ansible.cfg source. For more information see https://docs.ansible.com/ansible/devel/reference_appendices/config.html#cfg-in-world-writable-dir

You need to run the following command before running any ansible tasks

```
export ANSIBLE_CONFIG=./ansible.cfg
```

This will bypass the error.