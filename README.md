# devops-basics-2021-exam
Project built for SoftUni DevOps Basics course exam 2021

It is very much based on my previous project, but better organized and optimized.

This config will deploy 4 VMs -> Ansible, Jenkins Master, Jenkins Agent and Nagios system.
We expect automated pull, build, run of three conteinarized applications on the jenkins agent host.

Credit goes to below wonderful ansible galaxy contributers:

Jenkins master and Docker -> 
* https://galaxy.ansible.com/geerlingguy/jenkins
* https://galaxy.ansible.com/geerlingguy/docker

Jenkins slave node role -> 
* https://galaxy.ansible.com/lean_delivery/jenkins_slave

Nagios -> 
* https://galaxy.ansible.com/sdarwin/nagios
