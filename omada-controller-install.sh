#!/usr/bin/env bash
# Download latest release from the TP-LINK website
# https://www.tp-link.com/us/support/download/omada-software-controller/

# Install necessary packages
apt update --yes
apt upgrade --yes
apt install --yes mongodb jsvc openjdk-8-jdk

# Download package
wget -O omada.deb https://static.tp-link.com/upload/software/2022/202205/20220507/Omada_SDN_Controller_v5.3.1_Linux_x64.deb 
apt install ./omada.deb