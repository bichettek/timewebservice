| timewebservice |

A simple service that provide time in ruby based on chronic. 

Based on puppetlabs box (https://atlas.hashicorp.com/puppetlabs/boxes/centos-6.6-64-puppet), VirtualBox 5.0.16 and vagrant 1.8.1.
You will need VirtualBox and vagrant on your host machine.

#Usage
Within the path of Vagrantfile simply run : 
vagrant up

Vagrant will provide the ruby files corresponding to the timewebservice app and will provision ruby, rubygems, gems into the vm through puppet. 

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
