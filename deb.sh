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

apt=$(grep ^deb /etc/apt/sources.list | head -1)
debian_version=$(echo $apt | awk '{print $3}' | cut -d/ -f1)
echo $debian_version

declare -A v_emacs
v_emacs[squeeze]='emacs23-nox'
v_emacs[wheezy]='emacs23-nox'
v_emacs[jessie]='emacs24-nox'
v_emacs[sid]='emacs24-nox'
v_emacs[precise]='emacs23-nox'
v_emacs[trusty]='emacs24-nox'

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
    case $1 in
      emacs)
        version=${v_emacs[$debian_version]}
        ;;
      *)
        version=$1
    esac

    echo $version ...
    apt-get -qq -y install $version
  fi
}

r ()
{
  apt-get remove $1
}

tty-arduino ()
{
  i arduino-core
  i arduino-mighty-1284p
  i arduino-mk
  i avr-libc
  i avrdude
  i flashrom
  i fritzing
  i gcc-avr
  i picocom
}

tty-bak ()
{
  i lzop
  i rdiff
  i rdiff-backup
  i rsync
  i storebackup
  i tardiff
  i xdelta3
}

tty-dev ()
{
  i build-essential
  i byacc
  i cmake
  i exuberant-ctags
  i flex
  i gcc
  i gengetopt
  i libgmp3-dev
  i libpcap-dev
}

tty-firm ()
{
  i firmware-atheros
  i firmware-linux-free
  i firmware-realtek
  i zd1211-firmware
}

db ()
{
  i mariadb-client
  i postgresql-client
  i sqlite3
}

tty-sysadmin ()
{
  i cron-apt
  i etckeeper
  i fail2ban
  i logcheck
  i ntpdate
  i postfix
}

tty-printer ()
{
  i cups
  i foomatic-db
  i lpr
  i paps
  i printer-driver-cups-pdf
}

tty-privacy ()
{
  i acl
  i cryptsetup
  i debian-keyring
  i ecryptfs-utils
  i encfs
  i foremost
  i gnupg
  i gnupg-agent
  i keychain
  i lynis
  i monkeysphere
  i pass
  i pinentry-curses
  i scalpel
  i secure-delete
  i signing-party
  i tor
  i torsocks
  i unhide
  i wipe
}

tty-sudo ()
{
  i sudo
}

tty-ldap ()
{
  i ldap-utils
}

tty-monitor ()
{
  i apachetop
  i arpwatch
  i atop
  i bmon
  i bwm-ng
  i cbm
  i collectl
  i dstat
  i fwlogwatch
  i htop
  i ifstat
  i iftop
  i ioping
  i iotop
  i iperf
  i iptraf
  i iwatch
  i mytop
  i netdiag
  i nethogs
  i nfswatch
  i nload
  i pktstat
  i slurm
  i speedometer
  i sysstat
  i tcptrack
  i vnstat
  i wavemon
  i whowatch
}

tty-network ()
{
  i autossh
  i cifs-utils
  i connect-proxy
  i corkscrew
  i cryptcat
  i dnsutils
  i ethtool
  i ipcalc
  i mosh
  i mtr
  i ncftp
  i netcat
  i netcat-openbsd
  i netcat-traditional
  i netcat6
  i netrw
  i netsed
  i ngrep
  i nmap
  i openssh-server
  i pssh
  i redsocks
  i smbclient
  i socat
  i sshfs
  i sshfs
  i tcpdump
  i tcpick
  i tcpslice
  i tcpxtract
  i telnet
  i tinc
  i trickle
  i tshark
  i vncsnapshot
  i wicd-curses
  i libncurses5-dev
}

tty-web ()
{
  i elinks
  i links2
  i lynx
  i urlscan
  i w3m
  i w3m-img
}

tty-terminal ()
{
  i bash
  i bash-completion
  i bash-doc
  i screen
  i tmux
  i vlock
}

tty-tty ()
{
  i aview
  i caca-utils
  i fbcat
  i fbi
  i fbterm
  i gpm
  i tree
}

tty-latex ()
{
  i latex-beamer
  i texi2html
  i texinfo
  i texlive-extra-utils
  i texlive-fonts-extra
  i texlive-fonts-recommended
  i texlive-latex-extra
}

tty-emacs ()
{
  i emacs
  i emacs-goodies-el
  i gnuplot-mode
  i vim
  i w3m-el
  i yaml-mode
  i yasnippet
}

tty-org ()
{
  i libical-parser-perl
  i pandoc
  i remind
}

tty-music ()
{
  i madplay
  i moc
  i sox
}

tty-chat ()
{
  i finch
  i irssi
}

tty-code ()
{
  i bzr
  i git-core
  i mercurial
  i php5-cli
  i python
  i python-pip
  i subversion
  i tig
  i xsltproc
}

tty-disk ()
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
  i realpath
  i renameutils
  i testdisk
}

tty-down ()
{
  i axel
  i curl
  i httpie
  i wget
}

tty-editor ()
{
  i ack-grep
  i silversearcher-ag
  i ed
  tty-emacs
}

tty-fonts ()
{
  i fonts-inconsolata
  i unifont
}

tty-graph ()
{
  i ditaa
  i gnuplot
  i graphviz
  i imagemagick
  i jp2a
}

tty-lamp ()
{
  i apache2-mpm-prefork
  i ca-certificates
  i libapache2-mod-php5
  i libcurl3
  i mariadb-server
  i openssl
  i php-cache-lite
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

tty-laptop ()
{
  i acpi
  i laptop-mode-tools
  i pm-utils
  i powertop
}

tty-mail ()
{
  i imapfilter
  i mutt-patched
  i notmuch
  i notmuch-emacs
  i notmuch-mutt
  i notmuch-vim
  i offlineimap
  i swaks
}

tty-media ()
{
  i jhead
  i mplayer
  i mplayer2
  i mkvtoolnix
}

tty-util ()
{
  i csvtool
  i html2text
  i inxi
  i manpages-es
  i parallel
  i most
  i par
  i pv
  i toilet
}

tty-python ()
{
  i ipython
  i python-docutils
  i python-setuptools
  i python-sphinx
  i python-virtualenv
  i rst2pdf
}

tty-salt()
{
  i salt-master
  i salt-minion
  i salt-ssh
  i salt-syndic
}

x ()
{
  i awesome
  i bleachbit
  i conky
  i libnotify-bin
  i lxappearance
  i lxrandr
  i osdsh
  i pinpoint
  i rdesktop
  i rxvt-unicode
  i rxvt-unicode-256color
  i scrot
  i shutter
  i terminator
  i thunar
  i vlc
  i vncviewer
  i wireshark
  i x11-utils
  i xcalib
  i xclip
  i xdot
  i xfonts-efont-unicode
  i xinit
  i xscreensaver
  i xsel
  i xserver-xorg
  i zathura
}

x-mail ()
{
  i icedove
  i icedove-l10n-es-ar
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
  i libreoffice-l10n-es
}

x-graph ()
{
  i geeqie
  i gimp
  i impressive
  i inkscape
  i pqiv
  i qiv
}

remove()
{
  r nano
}

reprap()
{
  i cura-engine
  i openscad
  i png23d
  i repsnapper
  i sfact
  i slic3r
  i yagv
}

only-tty ()
{
  remove
  tty-arduino
  tty-bak
  tty-chat
  tty-code
  tty-disk
  tty-down
  tty-editor
  tty-fonts
  tty-graph
  tty-lamp
  tty-laptop
  tty-latex
  tty-ldap
  tty-mail
  tty-media
  tty-monitor
  tty-music
  tty-network
  tty-org
  tty-printer
  tty-privacy
  tty-python
  tty-sysadmin
  tty-terminal
  tty-tty
  tty-util
  tty-salt
  tty-web
}

x-arduino ()
{
  i arduino
}

x-games ()
{
  i armagetronad
  i golly
}

x-scan ()
{
  i xsane
  i simple-scan
}

with-x ()
{
  x
  x-arduino
  x-code
  x-games
  x-graph
  x-mail
  x-office
  x-scan
  x-web
}

list-functions ()
{
  egrep "^[a-z-]+\ \(\)" "$0" | egrep "(x-|tty-)" | tr -d "()" | sort
}

while getopts "adefhlmnoprstuvx" OPTION
do
  case $OPTION in
    a)
      only-tty
      with-x
      ;;
    d)
      tty-db
      ;;
    e)
      tty-emacs
      ;;
    f)
      tty-firm
      ;;
    h)
      list-functions
      ;;
    l)
      tty-latex
      ;;
    m)
      tty-monitor
      ;;
    n)
      tty-network
      ;;
    o)
      tty-sudo
      ;;
    p)
      tty-privacy
      ;;
    r)
      reprap
      ;;
    s)
      tty-lamp
      ;;
    t)
      only-tty
      ;;
    u)
      u
      ;;
    v)
      tty-dev
      ;;
    x)
      with-x
      ;;
    *)
      exit
      ;;
  esac
done

# vim:tabstop=2:softtabstop=2:shiftwidth=2:expandtab
