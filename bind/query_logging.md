# DNS Query Logging

In the context of threat hunting and PvJ, monitoring your network's
DNS traffic can be very benefitial. Enabling DNS query logging is
usually as easy as issuing a command or enabling a setting or two in
your server software's configuration.

Scenarios that query logging is benefitial:

- Troubleshooting scoring issues (what is scorebot TRYING to resolve?)

- Checking if hosts are resolving known bad domains

- Is something atypical to your environment being queried?


On BIND9, you can easily check if query logging is enabled:
```
# rndc status | grep logging
```

If it is not on, enable it:
```
rndc querylog
```

You will now see messages in /var/log/(messages|syslog) resembling this:
```
Aug 15 12:37:31 bind named[8978]: kali 10.1.1.120#38595: query: badoperation.net IN A +E
```

It is important to realize that BIND9's query logging does not log
responses. For this, [dnscap](https://github.com/DNS-OARC/dnscap)
works well.

Installing dnscap is easy on Debian-based systems:
```
apt-get install -y libpcap-dev libldns-dev libbind-dev zlib1g-dev libyaml-perl libssl-dev
git clone https://github.com/DNS-OARC/dnscap.git
cd dnscap
git submodule update --init
./autogen.sh
./configure
make
make install
```

Running dnscap:
```
dnscap -i <interface> -g | tee -a dnscap.log
```

This will give you output like so:
```
[62] 2019-10-08 04:34:13.126837 [#0 wlp3s0 4095] \
	[192.168.88.196].43978 [192.168.88.1].53  \
	dns QUERY,NOERROR,42441,rd \
	1 badoperation.net,IN,AAAA 0 0 0
[62] 2019-10-08 04:34:13.169749 [#1 wlp3s0 4095] \
	[192.168.88.1].53 [192.168.88.196].43978  \
	dns QUERY,NOERROR,42441,qr|rd|ra \
	1 badoperation.net,IN,AAAA 0 0 0
[62] 2019-10-08 04:34:13.171467 [#2 wlp3s0 4095] \
	[192.168.88.196].38928 [192.168.88.1].53  \
	dns QUERY,NOERROR,30509,rd \
	1 badoperation.net,IN,MX 0 0 0
[62] 2019-10-08 04:34:13.204179 [#3 wlp3s0 4095] \
	[192.168.88.1].53 [192.168.88.196].38928  \
	dns QUERY,NOERROR,30509,qr|rd|ra \
	1 badoperation.net,IN,MX 0 0 0
[61] 2019-10-08 04:34:26.641668 [#4 wlp3s0 4095] \
	[192.168.88.196].53634 [192.168.88.1].53  \
	dns QUERY,NOERROR,43054,rd \
	1 play.google.com,IN,A 0 0 0
[61] 2019-10-08 04:34:26.641775 [#5 wlp3s0 4095] \
	[192.168.88.196].50623 [192.168.88.1].53  \
	dns QUERY,NOERROR,63573,rd \
	1 play.google.com,IN,AAAA 0 0 0
[89] 2019-10-08 04:34:26.668059 [#6 wlp3s0 4095] \
	[192.168.88.1].53 [192.168.88.196].50623  \
	dns QUERY,NOERROR,63573,qr|rd|ra \
	1 play.google.com,IN,AAAA \
	1 play.google.com,IN,AAAA,186,2607:f8b0:4007:803::200e 0 0
[77] 2019-10-08 04:34:26.686532 [#7 wlp3s0 4095] \
	[192.168.88.1].53 [192.168.88.196].53634  \
	dns QUERY,NOERROR,43054,qr|rd|ra \
	1 play.google.com,IN,A \
	1 play.google.com,IN,A,145,216.58.195.78 0 0
```

_dnscap_ is useful if you want to see what the scorebot is attempting
to resolve. Using the -a flag may be useful to filter requests from
the scorebot.
