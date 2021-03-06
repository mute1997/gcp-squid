#!/bin/bash

home=150.246.71.28/32
eth0=10.146.0.8
eth1=10.1.0.6
eth1_base=10.1.0.1

wget https://raw.githubusercontent.com/tests-always-included/mo/master/mo
chmod 744 mo

sudo apt -y update
sudo apt -y install squid
sudo systemctl enable squid

sudo echo "1 rt1" | sudo tee -a /etc/iproute2/rt_tables

ETH1_BASE=${eth1_base} ETH1_IP=${eth1} ./mo interfaces > i
HOME=${home} ETH0=${eth0} ETH1=${eth1} ./mo squid.conf > s
sudo cp i /etc/network/interfaces
sudo cp s /etc/squid/squid.conf

sudo sed -ie 's/setup = .*/setup = false/g' /etc/default/instance_configs.cfg

#sudo reboot
