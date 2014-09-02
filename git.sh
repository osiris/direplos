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

c()
{
  git clone $1
}

sudo mkdir -p /mnt/data
sudo chown $USER.$USER /mnt/data
sudo ln -s /mnt/data ~/data
cd ~/data

c osiris@malbec:~/git/config.git && cd config && make && cd ..
c osiris@malbec:~/git/org.git && ln -s ~/data/org ~/org
c osiris@malbec:~/git/osiux-bin.git bin
c https://github.com/osiris/osiris.github.com hmtl && ln -s ~/data/html
c https://github.com/osiris/osiux-blog blog && ln -s ~/data/blog
c https://github.com/osiris/org-bash-utils
c https://github.com/osiris/media-bash-utils
c https://github.com/gcoop-libre/codigos-cooperativos

mkdir -p ~/data/dev
cd ~/data/dev
c https://github.com/robertdavidgraham/masscan
c https://github.com/zmap/zmap

mkdir -p ~/data/dev/emacs-lisp
cd ~/data/dev/emacs-lisp
c git://orgmode.org/org-mode.git && cd org-mode && make && sudo make install

