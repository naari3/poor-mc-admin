#!/bin/sh

cat <<CFG | sudo tee /etc/cloud/cloud.cfg.d/15_mount_volume.cfg
#cloud-config
mounts:
  - [ "/dev/xvdb", "/minecraft", "ext4", "defaults,nofail", "0", "2" ]
CFG

sudo rm -rf /var/lib/cloud/*
