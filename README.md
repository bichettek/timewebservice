| timewebservice |

A simple service that provide time in ruby based on chronic. 

Based on puppetlabs box (https://atlas.hashicorp.com/puppetlabs/boxes/centos-6.6-64-puppet), VirtualBox 5.0.16 and vagrant 1.8.1.
You will need VirtualBox and vagrant on your host machine.

#Usage
Within the path of Vagrantfile simply run : 

vagrant up

Vagrant will provide the ruby files corresponding to the timewebservice app and will provision ruby, rubygems, gems into the vm through puppet. 

NB : If atlas is unvailable, you can download the box from : https://www.dropbox.com/sh/un3oin47nuu93nk/AABXqpxvUZ10d9qu54_Yd1mQa?dl=0

You will need to add the box to your vagrant local boxes with for exemple : 

vagrant box add centos-6.6-64-puppet.box --name centos-6.6-64-puppet


In a second time, you need to change the VagrantFile from 

config.vm.box = "puppetlabs/centos-6.6-64-puppet" 


to 


 config.vm.box = "centos-6.6-64-puppet"


#Credentials
username : root

password : puppet

#Webservice Test
Case 1, from your guest : 
wget localhost/utc/now -o /tmp/test.now

Case 2, from your host : 
- Disable the firewall (root user) : service iptables stop
- Add port forwarding in your VirtualBox VM configuration, for exemple forward port 80 from guest to port 8080 in your host.
- Test from tour favorite browser : localhost:8080/utc/now

#Webservice usage 
Examples

/utc/now → Current UTC time

/pdt/in+two+hours → Time two hours from now in PDT

/pdt/next+monday → Datetime for next Monday in PDT

/pdt/this+friday+at+noon → Datetime for this Friday at noon in PDT ("friday noon" works too)

/pdt/7+hours+before+tomorrow+at+noon → I think you get the point.

See Chronic documentation for more examples.

Ruby source from http://chronic.herokuapp.com/
