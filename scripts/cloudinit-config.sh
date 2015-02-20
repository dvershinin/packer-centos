#!/bin/sh -ex

provision_cloudinit() {
    if [ -f /etc/cloud/cloud.cfg ]; then
        mkdir -p /etc/cloud/cloud.cfg.d
        grep -vE " - ssh-authkey-fingerprints| - keys-to-console| - byobu| - phone-home| - final-message| - landscape" /etc/cloud/cloud.cfg > /etc/cloud/cloud.cfg.new
        mv -f /etc/cloud/cloud.cfg.new /etc/cloud/cloud.cfg
    fi

    cat <<EOF > /etc/cloud/cloud.cfg.d/99_defaults.cfg
system_info:
  default_user:
    name: root
debug: false
disable_root: false
no_ssh_fingerprints: true
ssh_pwauth: true
resize_rootfs: true
users: 
  - name: root  
    lock-passwd: false 
EOF
}

case $PROVISIONER in
    cloudinit)
        provision_cloudinit
        ;;
esac
