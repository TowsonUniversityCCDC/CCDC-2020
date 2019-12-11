#!/bin/sh

for pkg in $(dpkg -l |awk {'print $2'}); do
  dpkg -V $pkg 2>/dev/null;
done

