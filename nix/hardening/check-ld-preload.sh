#!/bin/sh

# Check /etd/ld.so.preload
echo "[+] Checking if /etc/ld.so.preload exists"
if [ -f /etc/ld.so.preload ]; then
    echo "  [*] It exists, here it is:"
    cat /etc/ld.so.preload
    mv /etc/ld.so.preload /etc/ld.so.preload.old
fi


