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

CRYPT='/mnt/data/ecryptfs'
NOCRYPT='/mnt/data/cifrado'

for DIR in $CRYPT $NOCRYPT
do
    sudo mkdir -p $DIR
    sudo chown $USER: $DIR
    sudo chmod 700 $DIR
done

if [ -d $CRYPT ]
then

  if [ -d $NOCRYPT ]
  then

    MOUNT=`mount | grep -o $CRYPT`

    if [ -z "$MOUNT" ]
    then
        sudo mount -t ecryptfs $CRYPT $NOCRYPT
    fi

  for LINK in .ssh .gnupg .imapfilter .password-store org
  do
    [[ ! -L $NOCRYPT/$LINK ]] && ln -f -s $NOCRYPT/$LINK ~/$LINK
  done

  fi

fi

