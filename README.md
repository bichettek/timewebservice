| timewebservice |
|================|
A simple service that provide time in ruby. 

Based on puppetlabs box (https://atlas.hashicorp.com/puppetlabs/boxes/centos-6.6-64-puppet), VirtualBox 5.0.16 and vagrant 1.8.1.

#Usage# 
Within the path of Vagrantfile simply run : 
vagrant up

Vagrant will provide the ruby files corresponding to the timewebservice app and will provision ruby, rubygems, gems into the vm through puppet. 

#Credentials#
username : root
password : puppet

