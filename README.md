## Vagrant and Ansible Setup

##### Introduction

Vagrant is tool for building complete development environments. You can use Vagrant to create a virtual server that runs within Mac or Windows. [More information on Vagrant](https://docs.vagrantup.com/v2/getting-started/index.html). Ansible is a configuration/deployment tool like Chef and Puppet. [More information on Ansible](http://docs.ansible.com/index.html)

##### Vagrant and Ansible Installation on Mac

1. Download and install the latest version of Vagrant: https://www.vagrantup.com/downloads.html 

1. Download and install the latest version of VirtualBox: https://www.virtualbox.org/wiki/Downloads 

1. To install Ansible on a Mac, install [Homebrew](http://brew.sh/) and run:
    ```shell
    brew update
    brew install ansible
    ```

##### Vagrant and Ansible Installation on Windows

The Ansible client isn’t supported on Windows yet, so it’s a bit of a PITA to get it running. I used the great documentation provided by Azavea Labs to get Ansible running.

1. Download and install the lastest version of Vagrant: https://www.vagrantup.com/downloads.html 

1. Download and install the latest version of VirtualBox: https://www.virtualbox.org/wiki/Downloads 

1. Download and install babun (this is a Linux-like console on Windows based on Cygwin, you can install Cygwin if you prefer): http://babun.github.io/

1. Launch babun (not cmd.exe) and install Python:

    ```shell
    pact install python python-paramiko python-crypto gcc-g++ wget openssh python-setuptools
    ```

1. Install pip (still in babun):

    ```shell
    python /usr/lib/python2.7/site-packages/easy_install.py pip
    ```

1. Install Ansible (still in babun):

    ```shell
    pip install ansible
    ```

1. Create an ansible-playbook.bat file and copy it into c:\Windows\System32. Else Vagrant won’t be able to call Ansible using the Cygwin python.

    ```shell
    @echo off 
    REM http://www.azavea.com/blogs/labs/2014/10/running-vagrant-with-ansible-provisioning-on-windows/
    
    REM If you used the stand Cygwin installer this will be C:\cygwin 
    set CYGWIN=%USERPROFILE%\.babun\cygwin
    
    REM You can switch this to work with bash with %CYGWIN%\bin\bash.exe 
    set SH=%CYGWIN%\bin\zsh.exe
    
    %SH% -c "/bin/ansible-playbook %*"
   ```

##### Vagrant Deployment

1. Go to your Vagrant folder

    ```shell
    cd <root>/ubuntu-trusty64-railsbox
    ```

1. Edit 'Vagrantfile'. 
 * You'll need to change 'machine.vm.synced_folder' to the correct location of your code repo.
 * You may want to change memory allocation, port forwarding, etc.
 
1. Run Vagrant up to start the VM (this will also run Ansible to provision the server)

    ```shell
    vagrant up
    ```

1. To connect to your Vagrant instance:

    ```shell
    vagrant ssh
    ```
 * Login will be automatic using vagrant ssh
 * If you use putty or another SSH client, then the login is: vagrant / vagrant
 * The vagrant user has sudo access. If you need root access, the root password is 'vagrant'

##### Running Ansible

Everything that you need to prepare the Vagrant server is in the Ansible playbook. Ansible should have run with the **vagrant up** command and setup applications in the Vagrant virtual server.
* Global variables are stored in the following files. You shouldn’t need to change any of this information.
 * ansible/group_vars/all/config.yml
 * ansible/group_vars/development/config.yml. 
* You can provision as many times as you want. Ansible has checks so that it won't re-install apps that are already installed.

To provision (only necessary of errors occurred during **vagrant up**):
    
    vagrant provision

##### Sharing Your Vagrant Instance

1. To share you vagrant environment, you will need to create an account on [Vagrant Cloud](https://vagrantcloud.com/)

1. To allow remote HTTP Access:

    ```shell
    vagrant share
    ```
1. To allow remote SSH access:

    ```shell
    vagrant share --ssh
    ```
1. Packaging Your Vagrant VM, use Vagrant package:

    ```shell
    vagrant package --out "name of your VM"
    ```

1. To use the package:

    ```shell
    vagrant add "package name"
    vagrant up
    ```

##### Issues/Resolutions

1. If your laptop goes to sleep and you reconnect to a different wifi on wake-up, you may need to restart your Vagrant network:

    ```shell
    sudo /etc/init.d/networking restart
    ```

1. If Apache/Nginx complains about not having the correct hostname on startup, get your Vagrant hostname:

    ```shell
    hostname
    ```
 * And edit /etc/hosts with:
    ```shell
    127.0.0.1    {hostname returned from the above command}
    ```

1. If vagrant up complains that vboxsf file system is not available:

    ```shell
    sudo apt-get install -y kernel-devel
    ```

1. [Connection closes early](https://github.com/ualbertalib/Developer-Handbook/tree/master/Ansible)

Occasionally you'll see

    GATHERING FACTS ***************************************************************
    fatal: [192.168.20.50] - SSH encountered an unknown error during the connection. We recommend you re-run the command using -vvvv, which will enable SSH debugging output to help diagnose the issue

or something like

    fatal: [192.168.20.50] - failed to transfer file to /root/.ansible/tmp/ansible-tmp-1404920107.71-206926197576774/yum:
    mm_send_fd: sendmsg(2): Broken pipe
    mux_client_request_session: send fds failed
    Connection closed

This appears to be temporary so a naive workaround is to just try again. If you experience this continuously with Cygwin it seems to be caused by a known issue with OpenSSH on Windows.
The solution is to turn off the ControlMaster in ssh. You can set that in your ansible configuration file:

    [ssh_connection]
    ssh_args = -o ControlMaster=no

Ansible will look in several places for the config file:
* ansible.cfg in the current directory where you ran ansible-playbook
* ~/.ansible.cfg
* /etc/ansible/ansible.cfg
