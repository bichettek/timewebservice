# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|


  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "puppetlabs/centos-6.6-64-puppet"

  config.ssh.username = 'root'
  config.ssh.password = 'puppet'
  config.ssh.insert_key = 'true'
  

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     vb.gui = true
	 
	 vb.name = "TimeWebService"
  
     # Customize the amount of memory on the VM:
     vb.memory = "1024"
  end
  
  # Configuration for french keyboards
  config.vm.provision :file do |file|
    file.source      = 'provision/keyboard'
    file.destination = '/etc/sysconfig/keyboard'
  end
  

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.

  config.vm.provision :file do |file|
    file.source      = 'timewebservice'
    file.destination = '/opt/timewebservice'
  end
  
  # puppet.environment and puppet.environment_path mandatory for puppet 4.0 and above. 
  config.vm.provision "puppet" do |puppet|
	puppet.environment_path = "environments"
    puppet.environment = "TimeWebService"
    #puppet.manifest_file = "site.pp"
	#puppet.module_path = "modules"
  end
  

 
  
  #config.vm.provision "shell", inline: <<-SHELL
	#cd /opt/timewebservice/
	#ruby /opt/timewebservice/local.rb
	#reboot to load keyboard configuration 
	#reboot
	#service network restart
  #SHELL
  
end
