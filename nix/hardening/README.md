# Linux hardening

## Using trusted tools

Attackers may replace or backdoor userland utilities and libraries.

These userland rootkits work by replacing executables, libraries,
abusing shell functionality, ptrace() trickery, and other techniques.

TODO: Detecting userland rootkits

[get-trusted-tools.sh](get-trusted-tools.sh)


## Restricting temporary directories

Consider noexec, nodev, nosuid for /tmp, /var/tmp, and /dev/shm

TODO: instructions.


## lolbins

Attackers can also simply use the tools that come with the victim's
operating system to achieve their means.

https://gtfobins.github.io/ has a list of these types of files and
their capabilities.

Using this information practically, it has been proven effective to
limit the execution of these tools to users who do not need them. A
common example is why should the web server's user be permitted to run
netcat?

[lolbins-group-permissions.sh](lolbins-group-permissions.sh) is a
script that will create a group named _lolbins_ which you can then add
your team members' and appropriate service accounts to. Beware that
this script may break things on the hosts you apply it to.

This can be done on a smaller scale to certain tools, or create
multiple groups such as for networking tools (why does apache need to
ping or use netcat?), development tools (why does the ntp user need to
run gdb or strace?), etc.


## sbash

A common form of persistence is to add malicious code to a shell's
profile or rc files. To defend against this, you can compile your
shell to not process these files then assign this shell to important
users.

Here is how to do this with bash on an apt-based distro:

```
apt source bash && cd bash*
./configure --enable-static-link --without-bash-malloc
### Edit config-top.h; PPROMPT in config-top.h and #define SYSLOG_HISTORY
### Edit shell.c; set no_rc and no_profile = 1
make
```

This static-linked bash should work on most systems. Older systems may
give an error for the libc/kernel version not being compatible. These
systems can be skipped or you can compile bash in this manner on those
systems.

See
[change-user-passwords-add-ssh-keys.sh](change-user-passwords-add-ssh-keys.sh)
for an example of checking functionality and installing this shell.


## ptrace

Linux systems include the ptrace system call to debug processes. This
functionality is very useful when developing software; gdb, strace,
ltrace, etc rely on it being available.

The downside is that attackers will be able to debug processes as
well. This enables them to read, manipulate, and execute code within a
running process.

Many tools abuse ptrace() functionality to do things like steal
passwords from sudo or sshd, or hijack legitimate processes:

- https://github.com/blendin/3snake

- https://jvns.ca/blog/2014/02/17/spying-on-ssh-with-strace/

- https://github.com/droberson/papa-shango

NOTE: the version of papa-shango included with this repo includes a
payload that transforms any running process into a beacon.

See [disable-ptrace.sh](disable-ptrace.sh) for an example of how to
disable ptrace() on Linux systems.


## Upgrade packages

Upgrading packages is an easy way to fix a lot of known
vulnerabilities. You should check that the package manager's sources
are correct before installing/upgrading.

https://repogen.simplylinux.ch/

https://debgen.simplylinux.ch/

https://tecadmin.net/top-5-yum-repositories-for-centos-rhel-systems/

- apt-based systems:
```
apt update && apt upgrade -y
```
https://www.cyberciti.biz/tips/linux-debian-package-management-cheat-sheet.html

- yum-based systems:
```
yum update && yum upgrade -y
```
https://access.redhat.com/sites/default/files/attachments/rh_yum_cheatsheet_1214_jcs_print-1.pdf

- zypper-based systems:
```
zypper up
```
https://en.opensuse.org/images/1/17/Zypper-cheat-sheet-1.pdf


## SSH

- Use keys to login only
- Audit existing keys
- Review PAM modules/settings
- Consider making static-linked, ptrace-resistant sshds
- ssh-honeypot to attempt to steal backdoor logins/passwords

TODO: better content for this section


## Apache

- Check modules
- Look for webshells
- Review contents of web root directories
- Blocking known bad user-agents

TODO: how to audit modules
TODO: how to find webshells
TODO: php.ini disable_functions


## MySQL

- Change passwords (make sure web applications reflect this change)
- Is it necessary to be listening on non-loopback ips?

TODO: better content for this section


## Samba

- Make sure settings of shares are sane


## Asterisk

- Check for malicious manager accounts


## iptables

Host-based firewall rules are very effective. If time permits, setting
up sensible policies on these machines works pretty well. Malicious
east-west traffic can be blocked.

Some interesting and often overlooked iptables features are string
matching and rate limiting.

See [iptables.sh](iptables.sh) for an example of string matching ICMP
ping patterns to make tunneling and ICMP backdoors less effective.


## IPv6

IPv6 is often overlooked by defenders. Often, organizations will have
a very robust IPv4 firewall ruleset, but ignore IPv6 entirely.

See [this blog
post](https://dmfrsecurity.com/2018/07/01/bypassing-ipv4-security-measures-using-ipv6/)
for more information.

For simplicity's sake, we can simply disable IPv6 using
[disable-ipv6.sh](disable-ipv6.sh)


## lol-beacons

[lol-beacons](lol-beacons/lol-beacons.c) is an LD_PRELOAD library that
attempts to catch beacons. It will log the PID which launched the
beacon to syslog.

This is limited to payloads that use write() from dynamically linked
executables.
