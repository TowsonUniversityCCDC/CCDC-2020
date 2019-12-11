#!/bin/sh

YARAURL="http://badoperation.net/x/yara.tar.gz"

# thanks https://stackoverflow.com/a/677212  "How to check if a program exists from a Bash script?"
command -v wget >/dev/null 2>&1 || { echo >&2
    WGET="not found"
}
command -v curl >/dev/null 2>&1 || { echo >&2
    CURL="not found"
}
command -v tar >/dev/null 2>&1 || { echo >&2
    TAR="not found"
}
if [ "$WGET" = "not found" ] && [ "$CURL" = "not found" ]; then
    echo "Both curl and wget binaries are not found!"
    echo "   WGET: $WGET"
    echo "   CURL: $CURL"
    echo "You should consider installing them via a package manager like yum or apt."
    exit 1
fi

mkdir -p /opt/shadaloo/yara >/dev/null 2>/dev/null
if [ $? != 0 ]; then
    echo "[-] cant create /opt/shadaloo/yara. Exiting"
    exit 1
fi
mkdir -p /opt/shadaloo/tmp >/dev/null 2>/dev/null
if [ $? != 0 ]; then
    echo "[-] cant create /opt/shadaloo/tmp. Exiting"
    exit 1
fi

if [ "$WGET" != "not found" ]; then
    wget $YARAURL  -P /opt/shadaloo/tmp/
    tar zxvf /opt/shadaloo/tmp/yara.tar.gz -C /opt/shadaloo/yara
    exit
fi

curl -o /opt/shadaloo/tmp/yara.tar.gz $YARAURL
tar zxvf /opt/shadaloo/tmp/yara.tar.gz -C /opt/shadaloo/yara

