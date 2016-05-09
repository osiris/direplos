#!/bin/bash

F='/mnt/data/swapfile'

dd if=/dev/zero of="$F" bs=1M count=4096
chmod 0600 "$F"
mkswap "$F"
swapon "$F"

grep "$F" /etc/fstab
OK=`echo $?`

[[ "$OK" -eq 1 ]] && echo "$F none swap defaults 0 0" >>/etc/fstab

