# Generic Linux Checklist
* [ ] Triage image?
* [ ] Triage image exported off host?
* [ ] Known good binaries?
* [ ] Audit shadow file
  * [ ] Disable users in /etc/shadow with passwords. TODO: link one-liner/HOWTO
  * [ ] Do any users have unnecessary shells?
* [ ] Disable ALL ssh keys for ALL users. TODO: link one-liner/HOWTO
  * [ ] Install known-good keys for our team mates TODO: instructions for generating keys, collect ssh keys, place in google docs.
* [ ] Remote logging for syslog TODO: how to do with rsyslog and syslog-ng
* [ ] Cronjobs
* [ ] At jobs TODO: howto. consider killing/removing atd
* [ ] noawareness TODO: howto
* [ ] update packages TODO: howto
* [ ] Disable non-scored services TODO: howto
* [ ] Audit running processes TODO: howto
* [ ] Audit LKMs TODO: howto
* [ ] Check for LD_PRELOAD rootkits TODO: howto
* [ ] audit sudoers TODO: howto
  * [ ] /etc/sudoers.d/ _INCLUDING README_
* [ ] suid root binaries
* [ ] world-writable stuff
* [ ] stuff with weird attributes TODO: 1-liner
* [ ] /tmp noexec
* [ ] check /var/tmp, /dev/shm, /tmp for nasty stuff
* [ ] replace bashrcs with known-good.
  * [ ] set immutable bit?
* [ ] enable process accounting
