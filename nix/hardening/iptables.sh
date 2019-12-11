#!/bin/sh

iptables -F
iptables -X


# Only allow nettools ping and ping.exe patterns. This is to prevent tunneling
# and ICMP-based backdoors
iptables -I INPUT -p icmp -j DROP
iptables -I INPUT -p icmp -m string  --algo bm --string 'abcdefghijklmnopqrstuvwabcdefghi' -j ACCEPT
iptables -I INPUT -p icmp -m string  --algo bm --string '+,-./01234567' -j ACCEPT

# Set up logging chain
iptables -N LOGGING
iptables -A INPUT -j LOGGING
iptables -A OUTPUT -j LOGGING
iptables -A LOGGING -m limit --limit 1/sec -j LOG --log-prefix "iptables-dropped: " --log-level 4
iptables -A LOGGING -j ACCEPT

echo ""
echo "Success! Iptables updated to only good ping patterns"
echo ""