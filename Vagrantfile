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
    # Set memory & cpus
    vb.memory = 8192
    vb.cpus = 4
  end

  # Launch shell script for provisioning the VM
  config.vm.provision:shell, path: "bootstrap.sh"

  # Reboot after provisioning
  config.vm.provision :shell do |shell|
    shell.privileged = true
    shell.inline = 'echo Rebooting...'
    shell.reboot = true
  end
end
