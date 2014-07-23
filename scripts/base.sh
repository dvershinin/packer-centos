#!/bin/bash -ex


cat /etc/centos-release
grep -q " 6\." /etc/centos-release && rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && yum -y install cloud-init
grep -q " 7\." /etc/centos-release && rpm -Uvh http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm && yum -y --enablerepo="epel" install cloud-init


rm -f /etc/udev/rules.d/70-persistent-net.rules 
