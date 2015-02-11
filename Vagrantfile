# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Read site name from ENV or use the dir name of the parent directory (assumed to be the project name)
SITE_NAME = ENV["V_SITE_NAME"] || File.basename(File.expand_path("../..",__FILE__))

# Apt mirror to use by the box, defaults to 'archive.ubuntu.com', change to one closer to your location if needed
# APT_MIRROR = ENV["V_APT_MIRROR"] || "archive.ubuntu.com"

# Automatically upgrade virtual box guest additions if vbguest plugin is installed or not
VBGUEST_AUTO = ENV["V_VBGUEST_AUTO"] || "1"

puts "V_SITE_NAME: #{SITE_NAME}"
puts "V_VBGUEST_AUTO: #{VBGUEST_AUTO}"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Ubuntu 12.04 (precise) server, loaded from Canonical
  config.vm.box = "trusty64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  # Forward httpd and mysql
  config.vm.network :forwarded_port, guest: 8080, host: 8080
  config.vm.network :forwarded_port, guest: 3306, host: 3306

  # Sometimes good to have the box in a specific IP
  # config.vm.network :private_network, ip: "192.168.33.10"

  # If the vagrant project was unpacked inside the web project root, the parent folder contains the site root
  config.vm.synced_folder "../", "/var/www/#{SITE_NAME}",
    owner: "vagrant", 
    group: "www-data", 
    mount_options: ["umask=0002", "dmask=0002", "fmask=0002"]

  # Customize box name to avoid 20 different "vagrant_..." VM's inside VirtualBox GUI
  config.vm.provider :virtualbox do |vb|
    vb.name = "#{SITE_NAME}.dev_" + Time::now().strftime("%s")
    vb.gui = false # set to true to debug boot problems (like GRUB waiting for input after error recovery)
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  # Enable provisioning with Puppet stand alone. Location of manifests and modules should be straightforward
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "default.pp"
    puppet.module_path    = "puppet/modules"
    puppet.facter         = {
      :fqdn => "localdomain", 
      :site_name => SITE_NAME,
    }
  end

  if Vagrant.has_plugin?("vagrant-vbguest")
    unless VBGUEST_AUTO == "1"
      puts "Skipping vbguest auto update"
      config.vbguest.auto_update = false
    end
  else
    puts "Installing vagrant-vbguest plugin is highly recommended!"
  end

end
