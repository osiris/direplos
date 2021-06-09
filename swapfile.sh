#!/bin/bash

# This script comes with ABSOLUTELY NO WARRANTY, use at own risk
# Copyright (C) 2021 Osiris Alejandro Gomez <osiux@osiux.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

F='/mnt/data/swapfile'

[[ -z "$1" ]] || F="$1"

dd if=/dev/zero of="$F" bs=1M count=4096
chmod 0600 "$F"
mkswap "$F"
swapon "$F"

grep "$F" /etc/fstab

[[ "$?" -eq 1 ]] && echo "$F none swap defaults 0 0" >>/etc/fstab

echo 1 > /proc/sys/vm/swappiness
