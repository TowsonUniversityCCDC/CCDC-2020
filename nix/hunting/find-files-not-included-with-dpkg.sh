#!/bin/sh

find / -type f -exec dpkg -S {} \; 2>&1 |grep "no path found matching" |awk {'print $7'}

