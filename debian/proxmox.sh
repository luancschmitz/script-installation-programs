#!/bin/bash

# Instalacja proxmox



echo "deb [arch=amd64] http://download.proxmox.com/debian/pve bullseye pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
sudo su << SUDO_COMANDS
wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg
# verify
sha512sum /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg 7fb03ec8a1675723d2853b84aa4fdb49a46a3bb72b9951361488bfd19b29aab0a789a4f8c7406e71a69aabbc727c936d3549731c4659ffa1a08f44db8fdcebfa  /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg 
SUDO_COMANDS
apt update && apt full-upgrade -y
apt install proxmox-ve postfix open-iscsi
apt remove os-prober
apt remove linux-image-amd64 'linux-image-5.10*'
update-grub
# resolv.conf gets overwritten
# The PVE GUI expects to control DNS management and will no longer take its DNS settings from /etc/network/interfaces. 
# Any package that auto-generates (overwrites) /etc/resolv.conf will cause DNS to fail, e.g. packages 'resolvconf' for IPv4 and 'rdnssd' for IPv6.