# Defines our Vagrant environment
#
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # create controlnode node
  config.vm.define :controlnode do |controlnode_config|
      controlnode_config.vm.box = "bento/centos-7.2"
      controlnode_config.vm.hostname = "controlnode"
      controlnode_config.vm.network :private_network, ip: "10.0.15.10"
      controlnode_config.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
      end
      controlnode_config.vm.provision :shell, path: "bootstrap-controlnode.sh"
  end

  # create some web servers
  # https://docs.vagrantup.com/v2/vagrantfile/tips.html
  (1..2).each do |i|
    config.vm.define "web#{i}" do |node|
        node.vm.box = "bento/centos-7.2"
        node.vm.hostname = "web#{i}"
        node.vm.network :private_network, ip: "10.0.15.2#{i}"
        node.vm.network "forwarded_port", guest: 80, host: "808#{i}"
        node.vm.provider "virtualbox" do |vb|
          vb.memory = "256"
        end
        node.vm.provision "ansible" do |ansible|
          ansible.playbook = "provision-web.yml"
        end
    end
  end
  (1..2).each do |i|
    config.vm.define "app#{i}" do |node|
        node.vm.box = "bento/centos-7.2"
        node.vm.hostname = "app#{i}"
        node.vm.network :private_network, ip: "10.0.15.3#{i}"
        node.vm.network "forwarded_port", guest: 80, host: "909#{i}"
        node.vm.provider "virtualbox" do |vb|
          vb.memory = "256"
        end
        node.vm.provision "ansible" do |ansible|
          ansible.playbook = "provision-app.yml"
        end
    end
  end

end
