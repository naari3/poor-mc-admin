#!/bin/sh

cat <<CFG | sudo tee /etc/cloud/cloud.cfg.d/15_mount_volume.cfg
#cloud-config
mounts:
  - [ "/dev/sdb", "/minecraft", "ext4", "defaults,nofail", "0", "2" ]
runcmd:
  - sudo rm -rf /var/lib/cloud/* && sudo cloud-init init --local && sudo cloud-init init && sudo cloud-init modules --mode config && sudo cloud-init modules --mode final
CFG
