#!/bin/sh
# see https://github.com/koalaman/shellcheck/wiki/Ignore
# shellcheck disable=SC2016

# python3 -c 'import crypt; print(crypt.crypt("putpasswordhere", crypt.mksalt(crypt.METHOD_SHA512)))'
ROOTHASH='$6$fPySXcN8PJ/3emaI$3P3ihTcVMtS2YpyohWspwRwp9JbvGt2pqGoUUhRIsGDftoApHq6DHBWg1q.RdW/0LlKfP7jI0wm/o5y0qhrcG1'

echo "[+] Changing root's password."
if ! echo "root:$ROOTHASH" |chpasswd -e
then
    echo "[-] Failed to set root's password. Exiting."
    exit 1
fi

