#!/bin/sh

# Check for golang bins
for file in /tmp/* /var/tmp/* /bin/* /sbin/* /usr/bin/* /usr/sbin/*; do x=$(stri  ngs $file 2>/dev/null|grep /go- |wc -l); if [ $x -gt 3 ]; then echo $file; fi; done


