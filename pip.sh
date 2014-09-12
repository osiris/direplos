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

a ()
{
  i xdebugtoolkit
  i doga
}

while getopts "ui" OPTION
do
  case $OPTION in
    u)
      upgrade=1
      ;;
    i)
      a
      ;;
    *)
      exit
      ;;
  esac
done

