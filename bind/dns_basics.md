# Basic DNS commands

Querying a specific DNS server:
```
 % host -t A www.google.com 192.168.10.1
Using domain server:
Name: 192.168.10.1
Address: 192.168.10.1#53
Aliases:

www.google.com has address 172.217.14.68
```

Querying a specific DNS server using nslookup (works on Windows too):
```
% nslookup
> server 192.168.10.1
Default server: 192.168.10.1
Address: 192.168.10.1#53
> www.google.com
Server:		192.168.10.1
Address:	192.168.10.1#53

Non-authoritative answer:
Name:	www.google.com
Address: 172.217.14.68
Name:	www.google.com
Address: 2607:f8b0:4007:803::2004
> exit
```

Querying a DNS server's version:
```
% dig @192.168.10.1 version.bind chaos txt

; <<>> DiG 9.11.3-1ubuntu1.9-Ubuntu <<>> @192.168.10.1 version.bind chaos txt
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 45444
;; flags: qr aa rd ra ad; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;version.bind.			CH	TXT

;; ANSWER SECTION:
version.bind.		1	CH	TXT	"dnsmasq-2.79"

;; Query time: 5 msec
;; SERVER: 192.168.10.1#53(192.168.10.1)
;; WHEN: Mon Oct 07 22:01:01 PDT 2019
;; MSG SIZE  rcvd: 66
```
