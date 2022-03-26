# -*- mode: ruby -*-
# vi: set ft=ruby :

# Specify Vagrant version for consistent experience
Vagrant.require_version ">= 2.2.19"

Vagrant.configure("2") do |config|

  # Pick Vagrant Box.  Should be a Microchip specific box based on Ubuntu Server?
  config.vm.box = "generic/ubuntu2004"
  # Control versioning of Box for consistent experience
  config.vm.box_version = ">= 3.6.10"
  
  # Set hostname
  config.vm.hostname = "sandbox"

  config.vm.provider "virtualbox" do |vb|
    # Set name for ease of identifying in VB GUI
    vb.name = "Throw The Switch"
    # Set memory & cpus to same as WSL2 (75-80% of machine RAM).  24GB on 32GB machine
    vb.memory = 24576
    vb.cpus = 10
  end

  # Launch shell script for provisioning the VM
  config.vm.provision:shell, path: "bootstrap.sh"
end
