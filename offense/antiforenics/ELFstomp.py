#!/usr/bin/env python3

import os
import sys
import random


_ELF_MAGIC = b"\x7fELF"

try:
    elf = sys.argv[1]
except IndexError:
    exit(os.EX_USAGE)


with open(elf, "rb") as fp:
    header = fp.read(4)

    if header != _ELF_MAGIC:
        print("%s is not an ELF" % elf)
        exit(os.EX_USAGE)

with open(elf, "ab") as fp:
    random_bytes_length = random.randint(1,32)
    fp.write(os.urandom(random_bytes_length))
