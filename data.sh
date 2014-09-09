#!/bin/bash

# This script comes with ABSOLUTELY NO WARRANTY, use at own risk
# Copyright (C) 2014 Osiris Alejandro Gomez <osiux@osiux.com.ar>
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

mkdir -p /mnt/data/ecryptfs
mkdir -p /mnt/data/cifrado

if [ -d /mnt/data/ecryptfs ]
then

  if [ -d /mnt/data/cifrado ]
  then

  mount -t ecryptfs /mnt/data/ecryptfs/ /mnt/data/cifrado/

  ln -f -s /mnt/data/cifrado/.ssh ~/.ssh
  ln -f -s /mnt/data/cifrado/.gnupg ~/.gnupg
  ln -f -s /mnt/data/cifrado/.imapfilter ~/.imapfilter
  ln -f -s /mnt/data/cifrado/.password-store ~/.password-store
  ln -f -s /mnt/data/cifrado/org ~/org

  fi
fi

