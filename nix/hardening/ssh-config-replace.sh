#!/bin/sh

#Script to make a copy of the existing ssh and sshd config on a host
#then copy in a known good config 
#looking in /etc/ssh 


# Check /etc/ssh/ssh_config
echo "[+] Checking if /etc/ssh/ssh_config exists"
if [ -f /etc/ssh/ssh_config ]; then
    echo "  [*] It exists, creating a backup"
    mv /etc/ssh/ssh_config /etc/ssh/ssh_config.old
fi

	echo " [*] Replacing ssh_config"
	cat <<EOF > /etc/ssh/ssh_config
#ssh_config for Shadaloo for PvJ at 2019 BSidesDC
#Just the default client config to upload to ensure the Red Team didn't do anything weird


# This is the ssh client system-wide configuration file.  See
# ssh_config(5) for more information.  This file provides defaults for
# users, and the values can be changed in per-user configuration files
# or on the command line.

# Configuration data is parsed as follows:
#  1. command line options
#  2. user-specific file
#  3. system-wide file
# Any configuration value is only changed the first time it is set.
# Thus, host-specific definitions should be at the beginning of the
# configuration file, and defaults at the end.

# Site-wide defaults for some commonly used options.  For a comprehensive
# list of available options, their meanings and defaults, please see the
# ssh_config(5) man page.

Host *
#   ForwardAgent no
#   ForwardX11 no
#   ForwardX11Trusted yes
#   PasswordAuthentication yes
#   HostbasedAuthentication no
#   GSSAPIAuthentication no
#   GSSAPIDelegateCredentials no
#   GSSAPIKeyExchange no
#   GSSAPITrustDNS no
#   BatchMode no
#   CheckHostIP yes
#   AddressFamily any
#   ConnectTimeout 0
#   StrictHostKeyChecking ask
#   IdentityFile ~/.ssh/id_rsa
#   IdentityFile ~/.ssh/id_dsa
#   IdentityFile ~/.ssh/id_ecdsa
#   IdentityFile ~/.ssh/id_ed25519
#   Port 22
#   Protocol 2
#   Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc
#   MACs hmac-md5,hmac-sha1,umac-64@openssh.com
#   EscapeChar ~
#   Tunnel no
#   TunnelDevice any:any
#   PermitLocalCommand no
#   VisualHostKey no
#   ProxyCommand ssh -q -W %h:%p gateway.example.com
#   RekeyLimit 1G 1h
    SendEnv LANG LC_*
    HashKnownHosts yes
    GSSAPIAuthentication yes

EOF


# Check /etc/ssh/sshd_config
echo "[+] Checking if /etc/ssh/sshd_config exists"
if [ -f /etc/ssh/sshd_config ]; then
    echo "  [*] It exists, creating a backup"
    mv /etc/ssh/sshd_config /etc/ssh/sshd_config.old
fi


        echo " [*] Replacing sshd_config"
        cat <<EOF > /etc/ssh/sshd_config

#	$OpenBSD: sshd_config,v 1.101 2017/03/14 07:19:07 djm Exp $

#2019 sshd_config for Shadaloo 2019 BSides DC
#Started from https://linux-audit.com/audit-and-harden-your-ssh-configuration/

# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

# This sshd was compiled with PATH=/usr/bin:/bin:/usr/sbin:/sbin

# The strategy used for options in the default sshd_config shipped with
# OpenSSH is to specify options with their default value where
# possible, but leave them commented.  Uncommented options override the
# default value.

Port 22
#AddressFamily any
#ListenAddress 0.0.0.0
#ListenAddress ::

#HostKey /etc/ssh/ssh_host_rsa_key
#HostKey /etc/ssh/ssh_host_ecdsa_key
#HostKey /etc/ssh/ssh_host_ed25519_key

# Ciphers and keying
#RekeyLimit default none

# Logging
#SyslogFacility AUTH
#LogLevel INFO

# Authentication:

#LoginGraceTime 2m
#PermitRootLogin prohibit-password
#StrictModes yes
MaxAuthTries 3
#MaxSessions 10

PubkeyAuthentication yes

# Expect .ssh/authorized_keys2 to be disregarded by default in future.
AuthorizedKeysFile	.ssh/authorized_keys

#AuthorizedPrincipalsFile none

#AuthorizedKeysCommand none
#AuthorizedKeysCommandUser nobody

# For this to work you will also need host keys in /etc/ssh/ssh_known_hosts
#HostbasedAuthentication no
# Change to yes if you don't trust ~/.ssh/known_hosts for
# HostbasedAuthentication
#IgnoreUserKnownHosts no
# Don't read the user's ~/.rhosts and ~/.shosts files
#IgnoreRhosts yes

# To disable tunneled clear text passwords, change to no here!
PasswordAuthentication no
PermitEmptyPasswords no

# Change to yes to enable challenge-response passwords (beware issues with
# some PAM modules and threads)
ChallengeResponseAuthentication no

# Kerberos options
#KerberosAuthentication no
#KerberosOrLocalPasswd yes
#KerberosTicketCleanup yes
#KerberosGetAFSToken no

# GSSAPI options
#GSSAPIAuthentication no
#GSSAPICleanupCredentials yes
#GSSAPIStrictAcceptorCheck yes
#GSSAPIKeyExchange no

# Set this to 'yes' to enable PAM authentication, account processing,
# and session processing. If this is enabled, PAM authentication will
# be allowed through the ChallengeResponseAuthentication and
# PasswordAuthentication.  Depending on your PAM configuration,
# PAM authentication via ChallengeResponseAuthentication may bypass
# the setting of "PermitRootLogin without-password".
# If you just want the PAM account and session checks to run without
# PAM authentication, then enable this but set PasswordAuthentication
# and ChallengeResponseAuthentication to 'no'.
UsePAM no

#AllowAgentForwarding yes
AllowTcpForwarding no
#GatewayPorts no
X11Forwarding no
#X11DisplayOffset 10
#X11UseLocalhost yes
PermitTTY yes
PrintMotd no
#PrintLastLog yes
#TCPKeepAlive yes
#UseLogin no
#PermitUserEnvironment no
#Compression delayed
#ClientAliveInterval 0
#ClientAliveCountMax 3
#UseDNS no
#PidFile /var/run/sshd.pid
#MaxStartups 10:30:100
#PermitTunnel no
#ChrootDirectory none
#VersionAddendum none

# no default banner path
#Banner none

# Allow client to pass locale environment variables
#AcceptEnv LANG LC_*

# override default of no subsystems
Subsystem sftp	/usr/lib/openssh/sftp-server
EOF

	echo ""
	echo "[+] Running sshd -t to check the validity of the configuration file and sanity of the keys"
	echo ""
	testoutput=$(sshd -t)
	echo "$testoutput"
	echo " [*] Do you want to reload sshd and enable the new config? (y - reload, n - exit, r - revert)"
	read userinput
	case $userinput in
     		y|Y)
          		echo " [*] Reloading sshd_config"
          		systemctl reload sshd
          		;;
	     	n|N)
          		echo " [*] Exiting - edit and reload the sshd_config manually"
          		exit
          		;;
		r|R)
			echo " [*] Reverting to the original sshd_config no reload necessary"
			mv /etc/ssh/sshd_config.old /etc/ssh/sshd_config
			rm /etc/ssh/sshd_config.old
			;;
     		*)
          		echo " [*] Sorry, invalid input"
			echo " [*] Exiting - edit and reload the sshd_config manually using"
			echo " [*] sudo systemctl reload sshd"
          		;;
	esac

