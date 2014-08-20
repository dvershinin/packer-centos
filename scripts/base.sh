#!/bin/bash -ex

yum -y upgrade  
cat <<EOF > /etc/resolv.conf
nameserver 2001:4860:4860::8888
nameserver 2001:4860:4860::8844
nameserver 8.8.8.8
nameserver 8.8.4.4
options timeout:2 attempts:1 rotate
EOF

cat <<EOF >  /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE="eth0"
BOOTPROTO=dhcp
NM_CONTROLLED="no"
PERSISTENT_DHCLIENT=1
ONBOOT="yes"
TYPE=Ethernet
DEFROUTE=yes
PEERDNS=yes
PEERROUTES=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes
IPV6_FAILURE_FATAL=yes
NAME="eth0"
EOF

grep -q " 7\." /etc/centos-release && rpm -Uvh http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm && yum -y --enablerepo="epel" install cloud-init

yum -y install qemu-guest-agent
sed -i 's|^disable_root:.*|disable_root: 0|g' /etc/cloud/cloud.cfg
sed -i 's|^ssh_pwauth:.*|ssh_pwauth: 1|g' /etc/cloud/cloud.cfg
ln --symbolic /dev/null /etc/udev/rules.d/80-net-name-slot.rules
sed -i 's|#UseDNS yes|UseDNS no|g' /etc/ssh/sshd_config
sed -i 's|GSSAPIAuthentication yes|GSSAPIAuthentication no|g'  /etc/ssh/sshd_config
sed -i 's|PasswordAuthentication no|PasswordAuthentication yes|g' /etc/ssh/sshd_config
sed -i 's|#PermitRootLogin yes|PermitRootLogin yes|g' /etc/ssh/sshd_config

cat /etc/cloud/cloud.cfg
