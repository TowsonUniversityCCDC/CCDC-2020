#!/bin/sh

if [ -e /opt/shadaloo/bin/noawareness ]; then
    mkdir -p /etc/noawareness
    cat <<EOF >/etc/noawareness/inotify.conf
/etc
/var/tmp
/tmp
/root
/bin
/sbin
/usr/bin
/usr/sbin
/opt/shadaloo
EOF
fi


/opt/shadaloo/bin/noawareness -dOr -i /etc/noawareness/inotify.conf

# FreePBX tends to have kernels so old that it doesnt support all of the
# features that more modern kernels support via the netlink interface.
if [ $? != 0 ]; then
    /opt/shadaloo/bin/noawareness-fpbx -dOr -i /etc/noawareness/inotify.conf
fi
