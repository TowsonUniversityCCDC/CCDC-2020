#!/bin/sh

# Review all cronjobs
echo "[+] Disabling crond"
killall -9 crond
chmod 000 /sbin/crond /usr/sbin/crond /usr/bin/crond /bin/crond


# Review at jobs
echo "[+] Disabling atd"
killall -9 atd
chmod 000 /sbin/atd /usr/sbin/atd /bin/atd /usr/bin/atd


