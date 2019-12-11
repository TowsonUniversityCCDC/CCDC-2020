#!/bin/sh

# Find processes that are potentially lying about their argv[] in an attempt to hide in 'ps' output

for process in $(find /proc/[0-9]*/ -maxdepth 0 -type d); do
    pid=$(echo $process | cut -d / -f 3)

    # skip if cmdline is missing
    if [ ! -e ${process}cmdline ]; then
	continue
    fi
    cmdline=$(tr '\0' '|' < ${process}cmdline)

    # skip processes without command lines.
    if [ "$cmdline" = "" ]; then
	continue
    fi

    cmd=$(echo $cmdline |cut -d '|' -f 1)
    status=$(grep -E "^Name:" ${process}status)

    echo $cmdline | grep $(echo $status |awk '{print $2}') >/dev/null
    if [ $? = 1 ]; then
	echo "[+] This process is sketchy:"
	echo "  PID:             $pid"
        echo "  command:         $cmd"
	echo "  /proc/X/cmdline: $cmdline"
	echo "  /proc/X/status:  $status"
	echo
    fi
done
