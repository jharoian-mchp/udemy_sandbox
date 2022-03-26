#!/bin/bash
# Script to configure environment

# Utility Functions
step=1
step() {
    echo "[$step] ===== $1 ====="
    step=$((step+1))
}

# Setup Functions - call step("Title") to print step number and title in on screen log
# Add function call to bottom of file

setup_timezone() {
    step "Set Timezone"
    timedatectl set-timezone America/Los_Angeles
}

setup_update_packages() {
    step "Update Packages"

    # Get current
    apt-get update
    apt-get -y upgrade
    apt-get -y dist-upgrade

    # Clean up
    apt-get -y autoremove
}

setup_docker() {
    # From Docker Ubuntu install instructions: https://docs.docker.com/engine/install/ubuntu/

    # Remove any pre-installed packages
    apt-get -y remove docker docker-engine docker.io containerd runc

    # Add Docker pre-reqs
    apt-get -y install ca-certificates curl gnupg lsb-release

    # Add Docker's GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # Add Docker repo
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Update apt and install Docker
    apt-get update
    apt-get -y install docker-ce docker-ce-cli containerd.io
    apt-get -y upgrade

    # Add vagrant user to docker group
    usermod -a -G docker vagrant
}

pull_docker_image() {
    step "Pull docker image"
    docker pull throwtheswitch/drsurly-course1:latest

    # Make directory to share with docker
    mkdir -p /home/vagrant/Projects/lab 

    # Fix permissions
    chown -R vagrant:vagrant /home/vagrant/Projects

    # Install content
    docker run -t --rm -v /home/vagrant/Projects/lab:/lab throwtheswitch/drsurly-course1 course setup
}

setup_timezone
setup_update_packages
setup_docker
pull_docker_image
