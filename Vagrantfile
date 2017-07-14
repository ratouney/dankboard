# -*- mode: ruby -*-
# vi: set ft=YOLO :
VAGRANTFILE_API_VERSION = "2"

VM_NAME = "dank_vm"
MEMORY_SIZE_MB = 1024
NUMBER_OF_CPUS = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provision "shell", inline: <<-SHELL
     passwd -d -u ubuntu
     chage -d0 ubuntu
  SHELL
  
  config.vm.define "dank_box" do |dank_box|
    dank_box.vm.provider "virtualbox" do |v|
      v.name = VM_NAME
      v.customize ["modifyvm", :id, "--memory", MEMORY_SIZE_MB]
      v.customize ["modifyvm", :id, "--cpus", NUMBER_OF_CPUS]
    end
    dank_box.vm.network :private_network, ip: "192.168.55.55"
    dank_box.vm.network :forwarded_port, guest: 5432, host: 45432
    dank_box.vm.provision :shell, :path => "vagrant_provision.sh"
  end

  config.vm.synced_folder ".", "/home/ubuntu/project"
end