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

upgrade=0

i ()
{
  if [ $upgrade -eq 1 ]
  then
    pip install --upgrade $1
  else
    pip install $1
  fi
}

i3 ()
{
  apt install python3-pip
  pip3 install $1
}

ansible()
{
  i ansible==2.9.15
  i ansible-tower-cli==3.3.9
}

a3()
{
  i3 pyradio
}

a ()
{
  i asciinema
  i chronos
  i colout
  i diagram
  i doga
  i feedgen
  i glances
  i krill
  i mitmproxy
  i pack-ama
  i percol
  i pre-commit
  i roamer
  i visidata
  i xdebugtoolkit
  i yas3fs
  i yq
}

o ()
{
  i python-novaclient
  i python-glanceclient
  i python-keystoneclient
  i python-neutronclient
}

while getopts "uio" OPTION
do
  case $OPTION in
    u)
      upgrade=1
      ;;
    i)
      a
      ;;
    o)
      o
      ;;
    *)
      exit
      ;;
  esac
done

