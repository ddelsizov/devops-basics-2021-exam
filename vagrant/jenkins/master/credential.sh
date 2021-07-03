#!/bin/bash
echo "** Sleep for 30 seconds until Jenkins is UP after restart"
sudo sleep 30
echo "** Execute create credential for slavehost"
sudo cat /vagrant/slave.xml | sudo java -jar /opt/jenkins-cli.jar -s http://localhost:8080 -auth ddelsizov:secretpassword create-credentials-by-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "(global)"
echo "** Sleep for 30 seconds before running second credential add"
sudo sleep 30
echo "** Execute create credential for slavehost1"
sudo cat /vagrant/vagrant.xml | sudo java -jar /opt/jenkins-cli.jar -s http://localhost:8080 -auth ddelsizov:secretpassword create-credentials-by-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "(global)"

