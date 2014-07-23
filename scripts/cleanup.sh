#!/bin/sh

echo "==> Cleaning up yum cache of metadata and packages to save space"
yum -y clean all

rm -rf /tmp/*

