#!/bin/sh

# Check for suid/sgid
find / -perm -04000 -exec ls -l {} \; 2>/dev/null
find / -perm -02000 -exec ls -l {} \; 2>/dev/null


