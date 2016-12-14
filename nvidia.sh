#!/bin/bash

set -x
set -e

if [[ $EUID -ne 0 ]]; then
  # http://askubuntu.com/questions/15853/how-can-a-script-check-if-its-being-run-as-root
  echo "This script must be run as root"
  exit 1
fi

# Update to latest stuff
apt-get update && apt-get -y upgrade

# Add the relevant docker repositories
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | tee /etc/apt/sources.list.d/docker.list
apt-get update
apt-cache policy docker-engine

# Install requirements first
apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual

# Install docker
apt-get install -y docker-engine

# Test docker
docker run hello-world

# Install nvidia drivers
add-apt-repository -y ppa:graphics-drivers/ppa
apt-get update
apt-get install -y nvidia-367 # This version can change. Check PPA for latest version

# Install the kernel module
apt-get install -y nvidia-modprobe

# Add nvidia-docker extension
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.0-rc.3/nvidia-docker_1.0.0.rc.3-1_amd64.deb
dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb

# Test if nvidia-docker works
nvidia-docker run --rm nvidia/cuda nvidia-smi

# Move the docker images to /mnt where there's a *lot* more space
service docker stop
mv /var/log/docker /mnt
ln -s /mnt/docker /var/log/docker
service docker start
nvidia-docker run --rm nvidia/cuda nvidia-smi
