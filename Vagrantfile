

# coding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  # https://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-i386-v20140504.box
  config.vm.box = "centos71"
  # config.vm.box_url ="https://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140504.box"
  config.vm.box_url ="https://github.com/holms/vagrant-centos7-box/releases/download/7.1.1503.001/CentOS-7.1.1503-x86_64-netboot.box"
  
  # Symbolic links issue on windows
  config.vm.provider "virtualbox" do |v|
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
    v.memory = 1024
    v.cpus = 2
  end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8088  # apache 
  config.vm.network "forwarded_port", guest: 11211, host: 8082 # memcached

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  ####APACHE!!!! GID is set to 510 for apache, if value is changed remember to update apacheStuff.sh####
  config.vm.synced_folder "./project/", "/var/www/html/", id: "vagrant-root",
    mount_options: ["dmode=775,fmode=664,gid=510"]


  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  if Vagrant::Util::Platform.windows?
    # You MUST have a ~/.ssh/id_rsa.pub SSH key to copy to VM
    if File.exists?(File.join(Dir.home, ".ssh", "id_rsa.ppk")) or File.exists?(File.join(Dir.home, ".ssh", "id_rsa.pub"))
        # Read local machine's SSH Key (~/.ssh/id_rsa)
        ssh_key = File.read(File.join(Dir.home, ".ssh", "id_rsa.ppk"))
        pub_key = File.read(File.join(Dir.home, ".ssh", "id_rsa.pub"))
        # Copy it to VM as the /root/.ssh/id_rsa.ppk key
        config.vm.provision :shell, :inline => "echo 'Windows-specific: Copying local SSH Key to VM for provisioning...' && mkdir -p /root/.ssh && echo '#{ssh_key}' > /root/.ssh/id_rsa.ppk && chmod 600 /root/.ssh/id_rsa.ppk && echo '#{pub_key}' > /root/.ssh/id_rsa.pub && chmod 600 /root/.ssh/id_rsa.pub"
    else
        # Else, throw a Vagrant Error. Cannot successfully startup on Windows without a SSH Key!
        raise Vagrant::Errors::VagrantError, "\n\nERROR: SSH Key not found at ~/.ssh/id_rsa (required on Windows).\nYou can generate this key manually OR by installing for Windows (http://windows.github.com/)\n\n"
    end
  end

  # SSH AGENT FORWARDING - No need to create a new sshkey and link it to the bitbucket account
  config.ssh.forward_agent = true
  ## NOTE -- After the machine has been set up, please run this commands :) so the bitbucket domain
  ## could be added to known_hosts
  # $ vagrant ssh
  # [vagrant@localhost ~]$ ssh -T git@github.com

  #Provision script - run once
  config.vm.provision "file", source: "vscripts/nvm.sh", destination: "nvm.sh"
  config.vm.provision "file", source: "vscripts/tmpnpm.sh", destination: "tmpnpm.sh"

  config.vm.provision "shell", path: "vscripts/provision.sh"
  config.vm.provision "shell", path: "vscripts/apacheStuff.sh"
  #config.vm.provision "shell", path: "vscripts/cloneProject.sh"

  config.vm.provision "nodejs", type: "shell" do |s|
    s.path = "vscripts/nodejs.sh"
  end

  system('nmp install')

end