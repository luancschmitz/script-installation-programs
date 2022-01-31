#!/bin/bash

# Wersja dla użytku dla @norbezpl

# Instalowanie podstawowych narzędzi do linuxa desktop
sudo apt update
sudo apt upgrade -y
sudo add-apt-repository ppa:teejee2008/ppa
sudo apt install snapd ukuu net-tools ssh

# Instalacja google chrome
echo "Installing Chrome"
sleep 2s
cd ~/Downloads/
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i chrome.deb
sudo rm -r ~/Downloads/chrome.deb


# Instalacja programów ze snapstore
sudo snap install snap-store spotify thunderbird cacher telegram-desktop drawio bitwarden krita
sudo snap install code --classic
snap install android-studio --classic
snap install gitkraken --classic