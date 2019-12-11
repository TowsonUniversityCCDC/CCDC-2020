#!/bin/sh

# Check for UPX packed stuff
## apt install upx-ucl; upx -o outfile /bin/ls
find / -type f -executable -exec grep UPX! {} \; 2>/dev/null

