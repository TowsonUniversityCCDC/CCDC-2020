#!/bin/sh

# nuke sudoers, replace with our own
cat <<EOF >/etc/sudoers
es ALL=(ALL) ALL
EOF

