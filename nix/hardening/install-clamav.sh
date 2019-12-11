#!/bin/sh

command -v apt-get >/dev/null 2>&1 || { echo >&2
    APT_GET="not found"
}
command -v yum >/dev/null 2>&1 || { echo >&2
    YUM="not found"
}

if [ "$APT_GET" != 'not found' ]; then
    apt-get install -y clamav
    exit
fi

if [ "$YUM" != 'not found' ]; then
    yum install -y epel-release
    yum install -y clamav
    exit
fi

echo "[-] couldn't figure out how to install clamav."

