Vagrant LAMPP
=============

Vagrant box with Puppet Standalone provisioner. Install Apache2, MySQL, PHP and a couple of tools needed for PHP
development. The idea is to allow development completely inside the box, so it is not required to have any of these
tools installed on the host machine. 

For convenience, Puppet configures the default VHost for Apache2 to point to the project root directory and creates
a MySQL database.

The box is using Ubuntu 12.04 Server (Precise) 64bit as base box.

Preconditions
-------------

 * Vagrant 1.2.7, version 1.3.1. does not work due to a bug with NFS (Can't find the ticket anymore...)
 * VirtualBox
 * NFS Server. On Ubuntu Raring you need <tt>nfs-common</tt> and <tt>nfs-kernel-server</tt>. 

### NFS 

 * This box is using NFS to mount some folders for performance reasons. Hence the host system must have nfsd installed.    
 * For the same reason, this box does not work on Windows (and frankly, I care little). 
 * More info on NFS shared folder under http://docs.vagrantup.com/v2/synced-folders/nfs.html

Usage
-----

### Adding to a project

This is intended to be used as drop-in sub-module for an PHP development project. To add this box to a project, either
clone it into a sub-folder of your project root or preferrable add it as a submodule if you are already using Git on
the project:

````
git submodule add git@github.com:joerx/vagrant-lampp.git vagrant
```` 

The above command will create a new folder 'vagrant' inside your project containing the contents of this repository. 
The folder name 'vagrant' is not technically required, but recommended. More on submodules here: 
http://git-scm.com/book/ch6-6.html

### Folder structure

It is required to located the contents of this repository into a folder directly below the project root of your web application (see below why).
    
### Sudo

Due to it's NFS shared folders, the box will prompt for the root-password on boot

### Environment variables

Some customization of the Vagrant box can be achieved by setting environment variables before booting or provisioing
the box:
 * V_SITE_NAME: override the site name to be used (see below), otherwise the name of the parent folder is used
 * V_APT_MIRROR: allows to use an alternative apt-mirror for performance improvements. Defaults to 'archive.ubuntu.com'

Project Assumptions
-------------------

The box will set up the document root for the web servers default vhost and a MySQL database for the project 
automatically. It will do this based on an internal variable SITE_NAME. The SITE_NAME will be the base name of the 
parent of the folder the Vagrant file is located in. This can be overridden using the environment variable V_SITE_NAME.

Assuming you add this to a project called 'my_project', and given the directory structure below, SITE_NAME would be set 
to 'my_project'. 

````
.
|-- ...
`-- my_project
    |-- vagrant
    |   |-- puppet
    |   |-- README.md
    |   `-- Vagrantfile
    `-- ...
````

Based on this, the following configuration will be applied:
 * A shared folder 'my_project' --> '/var/www/my_project'
 * Folder '/var/www/my_project' will be used as document root for Apache2
 * A MySQL database 'my_project' will be created (user 'my_project', pass 'my_project')

Limitations
-----------

 * Cannot push to Git from inside the box as public SSL key is missing. Branch, commit, etc. works though

