Vagrant LAMPP
=============

Vagrant box with Puppet Standalone provisioner. Install Apache2, MySQL, PHP and 
a couple of tools needed for PHP development.

For convenience, Puppet configures the default VHost for Apache2 to point to 
the project root directory and creates a MySQL database.

The box is using Ubuntu 12.04 Server (Precise) 32bit as base box.

Preconditions
-------------

 * Vagrant 1.2.7 (Not tested on different version)
 * VirtualBox 

Usage
-----

### Adding To A Project

This is intended to be used as drop-in sub-module for an PHP development 
project. To add this box to a project, either clone it into a sub-folder of 
your project root or preferrable add it as a submodule if you are already 
using Git on the project:

````
git submodule add git@github.com:joerx/vagrant-lampp.git vagrant
```` 

The above command will create a new folder 'vagrant' inside your project 
containing the contents of this repository. The folder name 'vagrant' is not 
technically required, but recommended. 

More on Git submodules here: http://git-scm.com/book/ch6-6.html

### Folder Structure

It is required to located the contents of this repository into a folder 
directly below the project root of your web application (see below why).
   
### Environment variables

Some customization of the Vagrant box can be achieved by setting environment 
variables before booting or provisioning the box:
 * V_SITE_NAME: override the site name to be used (see below), otherwise the 
   name of the parent folder is used
 * V_APT_MIRROR: allows to use an alternative apt-mirror for performance 
   improvements. Defaults to 'archive.ubuntu.com'.

Project Assumptions
-------------------

The box will set up the document root for the web servers default vhost and a 
MySQL database for the project automatically. It will do this based on an 
internal variable SITE_NAME. The SITE_NAME will be the base name of the parent 
of the folder the Vagrant file is located in. This can be overridden using the 
environment variable V_SITE_NAME.

Assuming you add this to a project called 'my_project', and given the directory 
structure below, SITE_NAME would be set to 'my_project'. 

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
 * Folder '/var/www/my_project' as document root for Apache2
 * A MySQL database 'my_project', user 'my_project', pass 'my_project'

Limitations
-----------

 * Cannot push to Git from inside the box as public SSL key is missing. 
   Branch, commit, etc. works though. Copy the SSH-public/private key pair 
   your are using on Github to /home/vagrant/.ssh if you want to push from 
   inside the box 

License
-------

Copyright 2013 Jörg Henning &lt;henning.joerg@gmail.com&gt;

Licensed under the BSD License. (the "License"); you may not use this file 
except in compliance with the License. See the LICENSE file for details.

