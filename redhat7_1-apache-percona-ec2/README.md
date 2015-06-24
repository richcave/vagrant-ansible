This playbook will allow Vagrant to create a RedHat 7.1 instance with Apache and [Percona](https://www.percona.com/software/percona-server) (a drop-in MySQL replacement).

##### EC2 Setup

Change the following files for your EC2 instances:
* ec2.ini
* ec2instances

##### Before You Run Vagrant/Ansible

Before you run Vagrant and/or Ansible, you'll need to edit the following files and change all variables that have **CHANGE_ME**:
* roles/common/templates/root.my.cnf.j2
* roles/common/vars/main.yml