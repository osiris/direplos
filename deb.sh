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

apt="$(grep ^deb /etc/apt/sources.list | head -1)"
debian_version="$(echo "$apt" | awk '{print $3}' | cut -d/ -f1)"
echo "## $debian_version"

declare -A v_emacs
v_emacs[squeeze]='emacs23-nox'
v_emacs[wheezy]='emacs23-nox'
v_emacs[jessie]='emacs24-nox'
v_emacs[buster]='emacs25-nox'
v_emacs[bullseye]='emacs25-nox'
v_emacs[sid]='emacs24-nox'
v_emacs[precise]='emacs23-nox'
v_emacs[trusty]='emacs24-nox'

php_5 ()
{
  i libapache2-mod-php5
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
  i php5-cli
  i php5-curl
  i php5-imap
  i php5-mysql
  i php5-pgsql
  i php5-sqlite
}

php_7 ()
{
  i libapache2-mod-php7.4
  i php-cli
  i php-db
  i php-mail
  i php-mail-mime
  i php-mdb2-driver-pgsql
  i php-net-smtp
  i php-net-socket
  i php-net-url
  i php-pear
  i php7.4
  i php7.4-curl
  i php7.4-imap
  i php7.4-mysql
  i php7.4-pgsql
  i php7.4-soap
  i php7.4-sqlite3
}

tty-php ()
{
  case "$1" in
    buster|bullseye)
      php_7
      ;;
    *)
      php_5
      ;;
  esac
}

python2 ()
{
  i python2
  i ipython
  i python-apt
  i python-docutils
  i python-setuptools
  i python-sphinx
  i python-virtualenv
}

python3 ()
{
  i ipython3
  i python3
  i python3-apt
  i python3-docutils
  i python3-pip
  i python3-setuptools
  i python3-sphinx
  i python3-virtualenv
  r python3-samba
}

tty-python ()
{
  case "$1" in
    bullseye)
      python3
      ;;
    *)
      python2
      ;;
  esac
}

u ()
{
    apt-get update
}

a ()
{
  apt-get -qq -y install "$version" 2>>deb.err >>deb.log
}

i ()
{
  p="$(dpkg -l "$1" 2>>deb.err | grep -E ^ii | awk '{print $2}')"
  v="$(dpkg -l "$1" 2>>deb.err | grep -E ^ii | awk '{print $3}')"
  a="$(apt-cache show "$1" 2>>deb.err | grep -E "^Version" | head -1 | awk '{print $2}')"

  if [[ "$p" = "$1" ]]
  then
    printf "%25s\t%-25s\t%-25s\n" "$1" "$v" "$a"
  else
    version=''
    case "$1" in
      emacs)
        version=${v_emacs[$debian_version]}
        ;;
      php)
        tty-php "$debian_version"
        ;;
      python)
        tty-python "$debian_version"
        ;;
      *)
        version=$1
    esac

    if [[ -n "$version" ]]
    then
      if ! a ;
      then
        printf "%25s\t%-25s\n" "$version" "NOT_FOUND"
      fi
    fi

  fi
}

r ()
{
  apt-get remove -y "$1" 2>> deb.err >/dev/null
}

c ()
{
  apt-cache showpkg "$1" | grep -E "^Package: $1" >/dev/null
  echo "$?"
}

tty-ledger ()
{
  i hledger
  i hledger-ui
  i ledger
  i ledger-el
  i vim-ledger
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
  i lsyncd
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
  i expect
  i exuberant-ctags
  i flex
  i gcc
  i gengetopt
  i html-xml-utils
  i crudini
  i jq
  i libgmp3-dev
  i libpcap-dev
  i linkchecker
  i uuid
}

tty-games ()
{
  i vitetris
}

tty-virt ()
{
  i cloud-image-utils
  i ipxe-qemu
  i libvirt-clients
  i libvirt-daemon
  i ovmf
  i python3-libvirt
  i qemu-efi
  i qemu-efi-aarch64
  i qemu-efi-arm
  i qemu-system-arm
  i qemu-system-common
  i qemu-system-data
  i qemu-system-x86
  i qemu-utils
  i virt-manager
}

tty-firm ()
{
  i firmware-atheros
  i firmware-linux-free
  i firmware-realtek
  i firmware-sof-signed
  i zd1211-firmware
}

tty-db ()
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
  i grepcidr
  i logcheck
  i ntpdate
  i postfix
  i rgx
  i s-tui
}

tty-printer ()
{
  i cups
  i foomatic-db
  i lpr
  i a2ps
  i paps
  i printer-driver-cups-pdf
}

tty-privacy ()
{
  i pwgen
  i acl
  i cryptsetup
  i debian-keyring
  i ecryptfs-utils
  i dmtx-utils
  i encfs
  i foremost
  i gnupg
  i gnupg-agent
  i keychain
  i lynis
  i monkeysphere
  i paperkey
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
  i ldb-tools
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
  i nmon
  i pktstat
  i slurm
  i smem
  i speedometer
  i sysstat
  i tcptrack
  i vnstat
  i wavemon
  i whowatch
}

x-network ()
{
  i zenmap
  i etherape
}

tty-snmp ()
{
  i braa
  i snmp
  i snmp-mibs-downloader
}

tty-network ()
{
  i arp-scan
  i autossh
  i cifs-utils
  i connect-proxy
  i corkscrew
  i cryptcat
  i dnsutils
  i ethtool
  i ipcalc
  i lftp
  i libncurses5-dev
  i mosh
  i mtr-tiny
  i ncftp
  i netcat
  i netcat6
  i netcat-openbsd
  i netcat-traditional
  i netrw
  i netsed
  i ngrep
  i nmap
  i openssh-server
  i ssh-audit
  i openvpn
  i pssh
  i redsocks
  i smbclient
  i socat
  i spfquery
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
  i wakeonlan
  i wicd-curses
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
  i exa
  i lolcat
  i screen
  i shellcheck
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
  i vifm
  i w3m-el
  i yaml-mode
  i yasnippet
}

tty-org ()
{
  i bsdmainutils
  i libical-parser-perl
  i pandoc
  i remind
  i rst2pdf
}

tty-music ()
{
  i alsa-utils
  i beets
  i cava
  i madplay
  i moc
  i mpgtx
  i pulsemixer
  i aumix
  i sox
}

tty-chat ()
{
  i finch
  i irssi
  i profanity
}

tty-code ()
{
  i bzr
  i colordiff
  i dos2unix
  i git
  i git-crecord
  i git-flow
  i mercurial
  i python
  i subversion
  i tig
  i giggle
  i xsltproc
}

tty-deb ()
{

URLS=$(cat << EOF
bat        https://github.com/sharkdp/bat/releases/download/v0.18.2/bat_0.18.2_amd64.deb
duf        https://github.com/muesli/duf/releases/download/v0.6.2/duf_0.6.2_linux_amd64.deb
gh         https://github.com/cli/cli/releases/download/v1.11.0/gh_1.11.0_linux_amd64.deb
lsd        https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb
hyperfine  https://github.com/sharkdp/hyperfine/releases/download/v1.13.0/hyperfine-musl_1.13.0_amd64.deb
EOF
)

echo "$URLS" | while read -r PKG URL
do

  [[ "$(c "$PKG")" -eq 0 ]] && continue

  DEB="$(echo "$URL" | rev | cut -d/ -f1 | rev)"
  [[ ! -e "$DEB" ]] && wget "$URL"
  dpkg -i "$DEB"

done

}

tty-disk ()
{
  i xfsdump
  i xfsprogs
  i detox
  i fdupes
  i gddrescue
  i gdisk
  i gpart
  i jmtpfs
  i mc
  i mtp-tools
  i ncdu
  i parted
  i ranger
  i realpath
  i renameutils
  i s3fs
  i testdisk
}

tty-down ()
{
  i axel
  i curl
  i httpie
  i wget
}

tty-torrent ()
{
  i rtorrent
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
  i fonts-ubuntu
  i unifont
}

tty-graph ()
{
  i ditaa
  i gnuplot
  i graphviz
  i imagemagick
  i webp
  i gocr
  i pngcrush
  i gromit-mpx
  i jp2a
  i plantuml
  i gource
}

tty-lamp ()
{
  i apache2-mpm-prefork
  i ca-certificates
  i goaccess
  i libcurl3
  i mariadb-server
  i openssl
  i php
}

tty-laptop ()
{
  i acpi
  i laptop-mode-tools
  i pm-utils
  i powertop
  i i7z
  i tlp
}

tty-mail ()
{
  i imapfilter
  i mpack
  i mutt-patched
  i notmuch
  i notmuch-addrlookup
  i notmuch-emacs
  i notmuch-mutt
  i notmuch-vim
  i offlineimap
  i procmail
  i ripmime
  i swaks
  i tnef
}

tty-media ()
{
  i exiv2
  i jhead
  i mkvtoolnix
  i mplayer
  i mplayer2
  i poc-streamer
}

tty-util ()
{
  i csvtool
  i datamash
  i fd-find
  i html2text
  i inxi
  i lshw
  i manpages-es
  i ministat
  i moreutils
  i most
  i par
  i parallel
  i pcal
  i pv
  i recode
  i toilet
  i unrar-free
  i daemontools
}

tty-salt ()
{
  i salt-master
  i salt-minion
  i salt-ssh
  i salt-syndic
}

x-awesome ()
{
  i awesome
  i bleachbit
  i conky
  i dzen2
  i filezilla
  i libnotify-bin
  i lxappearance
  i lxrandr
  i macchanger
  i mupdf
  i osdsh
  i pinpoint
  i rdesktop
  i remmina
  i remmina-plugin-rdp
  i remmina-plugin-vnc
  i rxvt-unicode
  i rxvt-unicode-256color
  i scrot
  i shutter
  i spice-client-gtk
  i terminator
  i thunar
  i tigervnc-viewer
  i vlc
  i vncviewer
  i wireshark
  i wmctrl
  i x11-utils
  i xautomation
  i xcalib
  i xclip
  i xdot
  i xdotool
  i xfonts-efont-unicode
  i xinit
  i xinput
  i xscreensaver
  i xscreensaver-gl
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
  i flameshot
  i geeqie
  i gimp
  i impressive
  i inkscape
  i peek
  i pqiv
  i qiv
}

x-dep ()
{
  i libgl1-mesa-glx
}

remove()
{
  r nano
  r python-samba
  r samba
  r samba-common
  r samba-common-bin
  r samba-dsdb-modules
  r samba-libs:amd64
  r samba-vfs-modules
  r vlc-plugin-samba
}

x-reprap()
{
  i cura
  i openscad
  i slic3r
  i yagv
}

tty-reprap()
{
  i cura-engine
  i png23d
  i repsnapper
  i sfact
}

tty-android()
{
  i scrcpy
}

only-tty ()
{
  tty-arduino
  tty-bak
  tty-chat
  tty-code
  tty-db
  tty-deb
  tty-dev
  tty-disk
  tty-down
  tty-editor
  tty-emacs
  tty-firm
  tty-fonts
  tty-games
  tty-graph
  tty-lamp
  tty-laptop
  tty-latex
  tty-ldap
  tty-ledger
  tty-mail
  tty-media
  tty-monitor
  tty-music
  tty-network
  tty-org
  tty-printer
  tty-privacy
  tty-snmp
  tty-sudo
  tty-sysadmin
  tty-terminal
  tty-torrent
  tty-tty
  tty-util
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

x-util ()
{
  i dmenu
}

with-x ()
{
  x-awesome
  x-arduino
  x-code
  x-dep
  x-games
  x-graph
  x-mail
  x-network
  x-office
  x-scan
  x-util
  x-web
}

list-functions ()
{
  grep -E "^[a-z-]+\ \(\)" "$0" \
    | grep -E "(x-|tty-)"       \
    | tr -d "()"                \
    | sort
}

while getopts "adefhlmnoprstuvVx" OPTION
do
  case $OPTION in
    a)
      remove
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
      tty-reprap
      x-reprap
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
      tty-code
      ;;
    V)
      tty-virt
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
