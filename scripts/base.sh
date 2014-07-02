#!/bin/bash -eux

echo "==> Configuring sshd_config options"

echo "==> Turning off sshd DNS lookup to prevent timeout delay"
echo "UseDNS no" >> /etc/ssh/sshd_config
echo "==> Disabling GSSAPI authentication to prevent timeout delay"
echo "GSSAPIAuthentication no" >> /etc/ssh/sshd_config

rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y install cloud-init
rm -f /etc/udev/rules.d/70-persistent-net.rules 
