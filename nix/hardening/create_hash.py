#!/usr/bin/env python3

import sys
import crypt

try:
    print(crypt.crypt(sys.argv[1], crypt.mksalt(crypt.METHOD_SHA512)))
except IndexError:
    print("usage: %s <password>" % sys.argv[0])

