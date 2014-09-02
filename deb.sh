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

u ()
{
    apt-get update
}

i ()
{
    p=$(dpkg -l $1 | egrep ^ii | awk '{print $2}')
    v=$(dpkg -l $1 | egrep ^ii | awk '{print $3}')
    a=$(apt-cache show $1 | egrep "^Version" | head -1 | awk '{print $2}')

    if [ "$p" = "$1" ]
    then
        printf "%25s\t%-25s\t%-25s\n" $1 $v $a
    else
        echo $1 ...
        apt-get -qq -y install $1
    fi
}

r ()
{
    apt-get remove $1
}

dev ()
{
    i build-essential
    i byacc
    i cmake
    i ctags
    i flex
    i gcc
    i gengetopt
    i libgmp3-dev
    i libpcap-dev
}

firm ()
{
    i firmware-atheros
    i firmware-linux-free
    i zd1211-firmware
}

db ()
{
    i mariadb-client
    i postgresql-client
    i sqlite3
}

lamp ()
{
    i apache2-mpm-prefork
    i ca-certificates
    i libapache2-mod-php5
    i libcurl3
    i mariadb-server
    i openssl
    i php-db
    i php-mail
    i php-mail-mime
    i php-mdb2-driver-pgsql
    i php-net-smtp
    i php-net-socket
    i php-net-url
    i php-pear
    i php-soap
    i php5
    i php5-curl
    i php5-imap
    i php5-mysql
    i php5-pgsql
    i php5-sqlite
}

sysadmin ()
{
    i cron-apt
    i etckeeper
    i fail2ban
    i logcheck
    i ntpdate
    i postfix
}

printer ()
{
    i lpr
    i cups
    i foomatic-db
}

privacy ()
{
    i cryptsetup
    i encfs
    i ecryptfs-utils
    i gnupg
    i sudo
}

network ()
{
    i atop
    i connect-proxy
    i corkscrew
    i ethtool
    i htop
    i iftop
    i iperf
    i ncftp
    i netcat
    i netcat-traditional
    i nload
    i openssh-server
    i pssh
    i redsocks
    i socat
    i sshfs
    i sshfs
    i tcpdump
    i tshark
    i vnstat
    i wicd-curses
}

web ()
{
    i elinks
    i links2
    i lynx
    i w3m
}

down ()
{
    i axel
    i curl
    i wget
}

terminal ()
{
    i bash-completion
    i screen
    i tmux
    i vlock
}

tty ()
{
    i caca-utils
    i fbi
    i fbterm
    i gpm
}

fonts ()
{
    i fonts-inconsolata
}

editor ()
{
    i ack-grep
    i ed
    i emacs24-nox
    i gnuplot-mode
    i vim
    i yasnippet
}

org ()
{
    i remind
    i libical-parser-perl
}

disk ()
{
    i detox
    i fdupes
    i gddrescue
    i gdisk
    i gpart
    i mc
    i ncdu
    i parted
    i ranger
    i renameutils
    i testdisk
}

music ()
{
    i moc
}

code ()
{
    i git-core
    i mercurial
    i php5-cli
    i python
    i python-pip
    i subversion
    i tig
}

util ()
{
    i manpages-es
    i most 
    i par
    i pv
    i toilet
}

mail ()
{
    i imapfilter
    i mutt-patched
    i notmuch
    i notmuch-emacs
    i notmuch-mutt
    i notmuch-vim
    i offlineimap
}

chat ()
{
    i finch
    i irssi
}

media ()
{
    i jhead
    i mplayer
    i mplayer2
    i mkvtoolnix
}

graph ()
{
    i ditaa
    i graphviz
    i imagemagick
    i gnuplot
}

python ()
{
    i python-setuptools
    i python-docutils
    i python-virtualenv
    i ipython
}

x ()
{
    i awesome
    i conky
    i libnotify-bin
    i lxappearance
    i lxrandr
    i osdsh
    i shutter
    i terminator
    i thunar
    i vlc
    i vncviewer
    i wireshark
    i x11-utils
    i xdot
    i xfonts-efont-unicode
    i xinit
    i xscreensaver
    i zathura
}

x-web ()
{
    i dillo
    i iceweasel
    i iceweasel-l10n-es-ar
    i midori
    i uzbl
}

x-code ()
{
    i gitg
    i gitk
    i meld
    i sqlitebrowser
    i pidgin
}

x-office ()
{
    i libreoffice
}

x-graph ()
{
    i geeqie
    i pqiv
    i qiv
    i inkscape
    i gimp
}

remove()
{
    r nano
}

only-tty ()
{
    chat
    code
    disk
    down
    editor
    fonts
    graph
    lamp
    mail
    media
    music
    network
    org
    printer
    privacy
    python
    remove
    sysadmin
    terminal
    tty
    util
    web
}

with-x ()
{
    x
    x-code
    x-office
    x-web
    x-graph
}

while getopts "adfstuvx" OPTION
    do
        case $OPTION in
            a)
                only-tty
                with-x
                ;;
            d)
                db
                ;;
            f)
                firm
                ;;
            s)
                lamp
                ;;
            t)
                only-tty
                ;;
            u)
                u
                ;;
            v)
                dev
                ;;
            x)
                with-x
                ;;
            *)
                exit
                ;;
        esac
    done

