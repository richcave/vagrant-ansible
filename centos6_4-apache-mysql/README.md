This playbook will allow Vagrant to create a CentOS 6.4 instance with Apache and MySQL.

##### Before You Run Vagrant/Ansible

Before you run Vagrant and/or Ansible, you'll need to edit the following files and change all variables that have **CHANGE_ME**:
* roles/common/templates/root.my.cnf.j2
* roles/common/vars/main.yml

##### Known Issues

To fix [the failure to mount folders](https://github.com/mitchellh/vagrant/issues/1657), do the following:

    ```shell
    sudo ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions\
    sudo yum install -y wget
    wget ftp://mirror.switch.ch/pool/4/mirror/scientificlinux/6.4/x86_64/updates/security/kernel-devel-2.6.32-358.23.2.el6.x86_64.rpm
    sudo rpm -Uvh kernel-devel-2.6.32-358.23.2.el6.x86_64.rpm
    ```
	
Back in Windows:

    c:\vagrant reload