# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

is_docker  = (!ARGV.nil? && ARGV.join('').include?('--provider=docker'))

# Every Vagrant virtual environment requires a box to build off of.
# Commented out because we are setting this for each provider
#config.vm.box = "sbl_virtualbox"

# Provider details
config.vm.provider "virtualbox" do |vb,override|
	vb.gui = true
	override.vm.box = "uomsystemsbiology/base-vbox"
end

config.vm.provider "docker" do |docker,override|	
    	docker.image = "uomsystemsbiology/base-docker"
    	docker.cmd = ["/sbin/my_init", "--enable-insecure-key"]
    	docker.has_ssh = true
    	override.vm.synced_folder ".", "/vagrant", disabled: true
end

config.vm.provider "aws" do |aws,override|
	override.vm.box = "uomsystemsbiology/base-aws"
	override.vm.synced_folder ".", "/vagrant", disabled: true
	aws.ami = "dummy"
	aws.region = "us-west-2"
	aws.instance_type = "t2.micro"
        aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
	aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
	aws.security_groups = "launch-wizard-5"
end

#Connection details
	config.ssh.username = "sbl"
	config.ssh.password = "sbl"
	config.ssh.insert_key = false
	
#Provisioning scripts
	config.vm.provision "shell", inline: "sudo mkdir /vagrant/temp -p;chmod 777 /vagrant/temp"
	config.vm.provision "file", source: "data", destination: "/vagrant/temp"
	
	config.vm.provision "shell", path: "scripts/build_nodesktop.sh", privileged: false	
	if !(is_docker)
		config.vm.provision "shell", path: "scripts/build_desktop.sh", privileged: false
	end	
	
	config.vm.provision "shell", path: "scripts/install_gawcurcra15_required_packages.sh", privileged: false

# Uncomment the lines below to make an ISO using remastersys and the remastersys.conf file	
#	if !(is_docker)
#	config.vm.provision "shell", path: "scripts/make_iso.sh", privileged: false
#	end

end
