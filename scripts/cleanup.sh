#!/bin/sh -ex


yum -y install cloud-init
echo "==> Cleaning up yum cache of metadata and packages to save space"
yum -y clean all

rm -rf /tmp/*

rm -f /etc/udev/rules.d/70-persistent-net.rules
