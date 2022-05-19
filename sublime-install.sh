#!/usr/bin/env bash

# Install GPG Key
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

# HTTPS Sources
apt install apt-transport-https

# Add the stable package
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Update packages
sudo apt update
sudo apt install sublime-text