#!/bin/sh

# This changes permissions on lolbins to only be executable by the lolbins
# group members.
#
# Beware; if you use an X11/Xorg display manager, this may cause your system
# not to boot properly. Add lightdm, xdm, etc to "lolbins" group if you are
# using a GUI.
#
# Beware again; this breaks apt. If you get gpg errors when doing apt updates,
# rename the _apt user or change this user's group to whatever lolbins is.
#

echo "[+] lolbins-group-permissions.sh"

deal_with_lolbin() {
    SUID=0
    SGID=0
    PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

    # Does this even exist?
    command -v $1 >/dev/null 2>&1 || { echo >&2
        echo "[-] $1 not found. Skipping."
        return 1
    }

    echo "[+] Checking $LOLBIN"

    # Get absolute path if this is a symlink.
    if [ -h $LOLBIN ]; then
        echo -n "  [*] $LOLBIN is a symbolic link to "
        # TODO test for FreeBSD. idk if readlink works
        LOLBIN=$(readlink -f $LOLBIN)
        echo $LOLBIN
    fi

    # Check if lolbin is suid/sgid
    if [ -u $LOLBIN ]; then
        SUID=1
    fi

    # If this is sgid, opt out of using the lolbins group
    if [ -g $LOLBIN ]; then
        SGID=1
        chmod 2750 $LOLBIN
        if [ $SUID -eq 1 ]; then
            chmod u+s $LOLBIN
        fi
        echo "  [*] Preserving groupship for sgid file $LOLBIN"
        echo -n "      "
        ls -l $LOLBIN
        return 0
    fi

    chgrp lolbins $LOLBIN
    chmod 750 $LOLBIN
    if [ $SUID -eq 1 ]; then
        chmod u+s $LOLBIN
    fi
    echo -n "      "
    ls -l $LOLBIN
    return 0
}


# Check if lolbins group exists. Try to create it if missing.
grep -E "^lolbins:" /etc/group >/dev/null
if [ $? != 0 ]; then
    groupadd lolbins
    if [ $? != 0 ]; then
        echo "[-] Can't add lolbins group (are you root?). Exiting."
        return 1
    fi
fi



# Package managers
LOLBIN_PKG_MANAGERS="apt-get aptitude apt dpkg rpm yum zypper pacman emerge"
for x in $LOLBIN_PKG_MANAGERS; do
    deal_with_lolbin $x
done


# Networking tools
LOLBIN_NET="aria2c nc netcat nc.openbsd nc.traditional curl wget nmap awk arp ping ping6 route ifconfig ip iptables tcpdump tshark traceroute tracepath traceroute6 mysql ssh sftp telnet openssl socat ftp lftp git scp sftp smbclient tftp whois"
for x in $LOLBIN_NET; do
    deal_with_lolbin $x
done

# File manipulation and reading
LOLBIN_FILE="cat diff base64 dd ls bash ed vi vim emacs file fold grep head less man pico nano puppet readelf red od xxd sed sqlite tar gzip gunzip zcat zless el uniq xargs tail script shuf tee sort mv cp ln"
for x in $LOLBIN_FILE; do
    deal_with_lolbin $x
done

# Shells, interpreters, debuggers, ...
# TODO  Skipped php
LOLBIN_DEV="ash bash busybox csh dash docker expect facter fish gdb ksh ltrace lua make r2 radare2 irb ruby perl python python2.7 tclsh pip node jjs puppet strace wish zsh"
for x in $LOLBIN_DEV; do
    deal_with_lolbin $x
done


# Misc
LOLBIN_MISC="date df dmesg dmsetup du id mount sudo whoami"
for x in $LOLBIN_MISC; do
    deal_with_lolbin $x
done

echo "[+] Done."

