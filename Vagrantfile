# -*- mode: ruby -*-
# vi: set ft=ruby :

$nagios = <<-SCRIPT
echo "* ADD hosts "
	echo "192.168.120.100 jvm.dob.exam jvm" >> /etc/hosts
	echo "192.168.120.101 dvm.dob.exam dvm" >> /etc/hosts
	echo "192.168.120.103 avm.dob.exam avm" >> /etc/hosts
	
echo "* Enable epel repo "
	sudo dnf install -y epel-release 
	sudo dnf install -y tar
	
echo "* Configure firewall rules "
	sudo firewall-cmd --add-port=80/tcp --permanent
	sudo firewall-cmd --add-port=8899/tcp --permanent
	sudo firewall-cmd --add-port=5666/tcp --permanent
	sudo firewall-cmd --reload

echo "* Update SELinux "
	sudo setenforce 0

echo "* Add nagios user, groups for role deps "
	sudo useradd nagios
	sudo groupadd nagcmd
	sudo groupadd sysadmin
	sudo groupadd nagios
	sudo echo "nagios:Password1change" | sudo chpasswd
	sudo usermod -a -G nagcmd nagios
	sudo usermod -a -G sysadmin nagios
	sudo usermod -a -G nagios nagios
	sudo echo 'nagios ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
SCRIPT

$configureAnsible = <<-SCRIPT
echo "* ADD hosts "
	echo "192.168.120.100 jvm.dob.exam jvm" >> /etc/hosts
	echo "192.168.120.101 dvm.dob.exam dvm" >> /etc/hosts
	echo "192.168.120.102 avm.dob.exam avm" >> /etc/hosts
	echo "192.168.120.103 nvm.dob.exam nvm" >> /etc/hosts
	
echo "* Install Ansible ..."
	sudo dnf install -y epel-release
	sudo dnf install -y ansible
	sudo dnf install -y tar
	
echo "* Update SELinux "
	sudo setenforce 0

echo "* Set Ansible configuration in /etc/ansible/ansible.cfg "
	cp /vagrant/ansible.cfg /etc/ansible/ansible.cfg

echo "* Set Ansible global inventory in /etc/ansible/hosts  "
	cp /vagrant/hosts /etc/ansible/hosts

echo "* Copy Ansible playbooks in /playbooks/  "
	cp -R /vagrant/playbooks /playbooks

echo "* Copy Jenkins slave role to /etc/ansible/roles "
	cp -ar /playbooks/lean_delivery.jenkins_slave /etc/ansible/roles

echo "* Install Ansible roles and collections from galaxy "
	ansible-galaxy collection install community.general
	ansible-galaxy install geerlingguy.jenkins -p /etc/ansible/roles
	ansible-galaxy install geerlingguy.docker -p /etc/ansible/roles
	ansible-galaxy install geerlingguy.java -p /etc/ansible/roles
	ansible-galaxy install sdarwin.nagios -p /etc/ansible/roles

echo "* Execute Ansible Playbooks "

echo "* Deploy Jenkins environmen via Ansible role "
	ansible-playbook /playbooks/install-all.yml
	
echo "* Deploy Nagios via Ansible role "
	ansible-playbook /playbooks/nagios.yml
SCRIPT

$configureMaster = <<-SCRIPT
echo "* ADD hosts "
	echo "192.168.120.100 jvm.dob.exam jvm" >> /etc/hosts
	echo "192.168.120.101 dvm.dob.exam dvm" >> /etc/hosts
	echo "192.168.120.102 avm.dob.exam avm" >> /etc/hosts
	echo "192.168.120.103 nvm.dob.exam nvm" >> /etc/hosts
	
echo "* Enable epel repo, install additional packages "
	sudo dnf install -y epel-release
	sudo dnf install -y tar
	sudo dnf install -y git 

echo "* Update firewall and few os setup tasks for Jenkins "
	sudo firewall-cmd --add-port=8080/tcp --permanent
	sudo firewall-cmd --add-port=5666/tcp --permanent
	sudo firewall-cmd --reload
	sudo useradd jenkins
	sudo echo "jenkins:secretpassword" | sudo chpasswd
	sudo echo 'jenkins ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
	
	
echo "* Add nagios user, groups for role deps "
	sudo useradd nagios
	sudo groupadd nagcmd
	sudo groupadd sysadmin
	sudo groupadd nagios
	sudo echo "nagios:Password1change" | sudo chpasswd
	sudo usermod -a -G nagcmd nagios
	sudo usermod -a -G sysadmin nagios
	sudo usermod -a -G nagios nagios
	sudo echo 'nagios ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

echo "* Update SELinux "
	sudo setenforce 0
SCRIPT

$configureSlave = <<-SCRIPT
echo "* Add jenkins user and modify stuff "
	sudo useradd jenkins
	sudo echo "jenkins:secretpassword" | sudo chpasswd
	sudo echo 'jenkins ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
	sudo mkdir -p /opt/jenkins
	sudo chown jenkins:jenkins -R /opt/jenkins
	
echo "* ADD hosts "
	echo "192.168.120.100 jvm.dob.exam jvm" >> /etc/hosts
	echo "192.168.120.101 dvm.dob.exam dvm" >> /etc/hosts
	echo "192.168.120.102 avm.dob.exam avm" >> /etc/hosts
	echo "192.168.120.103 nvm.dob.exam nvm" >> /etc/hosts


echo "* Install Java, python libs, tar, enable epel "
	sudo dnf install -y java-11-openjdk-devel
	sudo dnf install -y python3
	sudo dnf install -y python3-libselinux
	sudo dnf install -y tar
	sudo dnf install -y epel-release
	

echo "* Update SELinux "
	sudo setenforce 0

echo "* Enable IPv4 forwarding "

	sudo sysctl net.ipv4.conf.all.forwarding=1

echo "* Open ports in firewall"
	sudo firewall-cmd --add-port=80/tcp --permanent
	sudo firewall-cmd --add-port=3306/tcp --permanent
	sudo firewall-cmd --add-port=33060/tcp --permanent
	sudo firewall-cmd --add-port=2377/tcp --permanent
	sudo firewall-cmd --add-port=7946/tcp --permanent
	sudo firewall-cmd --add-port=7946/udp --permanent
    sudo firewall-cmd --add-port=4789/tcp --permanent
	sudo firewall-cmd --add-port=5000/tcp --permanent
	sudo firewall-cmd --add-port=5666/tcp --permanent
	sudo firewall-cmd --reload
	
echo "* Add nagios user, groups for role deps "
	sudo useradd nagios
	sudo groupadd nagcmd
	sudo groupadd sysadmin
	sudo groupadd nagios
	sudo echo "nagios:Password1change" | sudo chpasswd
	sudo usermod -a -G nagcmd nagios
	sudo usermod -a -G sysadmin nagios
	sudo usermod -a -G nagios nagios
	sudo echo 'nagios ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
SCRIPT

Vagrant.configure(2) do |config|
  config.ssh.insert_key = false 
  config.vm.define "jvm" do |jvm|
    jvm.vm.box = "shekeriev/centos-8-minimal"
    jvm.vm.hostname = "jvm.dob.exam"
    jvm.vm.network "private_network", ip: "192.168.120.100"
    jvm.vm.network "forwarded_port", guest: 8080, host: 8000
	jvm.vm.synced_folder "./vagrant/jenkins/master", "/vagrant"
    jvm.vm.provision "shell", inline: $configureMaster	
    end
   config.vm.define "dvm" do |dvm|
    dvm.vm.box = "shekeriev/centos-8-minimal"
    dvm.vm.hostname = "dvm.dob.exam"
    dvm.vm.network "private_network", ip: "192.168.120.101"
    dvm.vm.network "forwarded_port", guest: 5000, host: 8001
	dvm.vm.synced_folder "./vagrant/docker", "/vagrant", mount_options: ["dmode=755", "fmode=755"]
    dvm.vm.provision "shell", inline: $configureSlave	
	end  
   config.vm.define "nvm" do |nvm|
    nvm.vm.box = "shekeriev/centos-8-minimal"
    nvm.vm.hostname = "nvm.dob.exam"
    nvm.vm.network "private_network", ip: "192.168.120.103"
	nvm.vm.network "forwarded_port", guest: 80, host: 8002
	nvm.vm.provision "shell", inline: $nagios
	end
   config.vm.define "avm" do |avm|
    avm.vm.box = "shekeriev/centos-8-minimal"
    avm.vm.hostname = "avm.dob.exam"
    avm.vm.network "private_network", ip: "192.168.120.102"
	avm.vm.synced_folder "./vagrant/ansible", "/vagrant", mount_options: ["dmode=755", "fmode=755"]
    avm.vm.provision "shell", inline: $configureAnsible
	end
   end
   
