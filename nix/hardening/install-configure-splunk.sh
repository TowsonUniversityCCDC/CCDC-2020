#!/bin/sh

# set pass for splunk admin
SPLUNKPASS="youhavechimpanzeeacne"

# URL prefix
WWW="http://badoperation.net/x/"

# CHANGE THIS - icantstoptheblood
# python3 -c 'import crypt; print(crypt.crypt("putpasswordhere", crypt.mksalt(crypt.METHOD_SHA512)))'
ESHASH='$6$zBsogWtOBrf9qaH2$C3j01bUf830f.4.UcXL7lVh3pj7e9Gj/XlG3HORzFMZBoLAyUlJJchC4Liz4vxd5dHUMbB9zxfq56IxMYUlId1'

# todo - not hard code this to /opt/shadaloo ? This is dependent on /opt/shadaloo being populated with safe binaries we trust

# Make sure curl works; /opt/shadaloo/bin/curl doesnt work on older kernels
CURL_BIN=/opt/shadaloo/bin/curl
$CURL_BIN 2>/dev/null 1>/dev/null
if [ $? != 0 ]; then
    CURL_BIN=/usr/bin/curl
fi

# todo - not have this created here but in another script like /opt/shadaloo/bin above?
mkdir -p /opt/shadaloo/etc
mkdir -p /opt/shadaloo/installers

################
# Drop Splunk fowarder
################

#PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin

# this splunkclouduf.spl forwards all data to our SaaS instance
$CURL_BIN -o /opt/shadaloo/etc/splunkclouduf.spl ${WWW}splunk/splunkclouduf.spl
if [ -e /etc/debian_version ]; then
    $CURL_BIN -o /opt/shadaloo/installers/splunk.deb ${WWW}splunk/splunk.deb
    /usr/bin/dpkg -i /opt/shadaloo/installers/splunk.deb
elif [ -e /etc/redhat-release ] || [ -e /etc/centos-release ]; then
    useradd splunk
    groupadd splunk
    $CURL_BIN  -o /opt/shadaloo/installers/splunk.rpm ${WWW}splunk/splunk.rpm
    rpm -i /opt/shadaloo/installers/splunk.rpm
else
    $CURL_BIN -o ${WWW}splunk/splunk.tgz
    tar zxvf splunk.tgz -C /opt
fi


/opt/splunkforwarder/bin/splunk start --accept-license --no-prompt
sleep 2
# inject known user login and pass
echo "[user_info]" >  /opt/splunkforwarder/etc/system/local/user-seed.conf
echo "USERNAME = admin" >>  /opt/splunkforwarder/etc/system/local/user-seed.conf
echo "PASSWORD = $SPLUNKPASS" >> /opt/splunkforwarder/etc/system/local/user-seed.conf

# restart so user-seed.conf we just created takes affect
/opt/splunkforwarder/bin/splunk restart

# login, forward to our SaaS instance, add /var/log and start on boot
/opt/splunkforwarder/bin/splunk login -auth admin:$SPLUNKPASS
/opt/splunkforwarder/bin/splunk install app /opt/shadaloo/etc/splunkclouduf.spl
/opt/splunkforwarder/bin/splunk add monitor /var/log
/opt/splunkforwarder/bin/splunk enable boot-start

#todo  - maybe install the the unix app?
