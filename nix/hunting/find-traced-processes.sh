#!/bin/sh

# find processes that are being ptraced.
# This is to detect if malware is ptracing itself to avoid analysis, and to see
# if something like sshd is being strace'd in an attempt to steal passwords

for p in $(find /proc/[0-9]*/ -maxdepth 0 -type d); do
    pid=$(echo $p |cut -d / -f 3)
    tracerstatus=$(grep -E "^TracerPid:" <${p}status)
    if [ $? != 0 ]; then
        continue
    fi

    tracerpid=$(echo $tracerstatus |awk '{print $2}')

    if [ "$tracerpid" = "0" ]; then
        continue
    fi

    echo "[+] PID $pid is being traced by PID $tracerpid"
    ps -p $pid $tracerpid
    echo
done

