# BIND
We will probably have a BIND9 DNS server. It will most likely be running on a Linux system of some kind. The distro and version are unknown until the game day.


DNS is vital for the game's scoring:

- Scorebot receives a job (hostname, dns server, and service) from the
  game master's software.

- Scorebot connects to _dns server_ (controlled by us!) and tries to
  resolve _hostname_

  - if this fails, your service check fails

- Scorebot attempts to ping the IP address that your DNS server
  provided

  - if this fails, your service check fails

- Scorebot checks if _service_ is active. This may be FTP, HTTP, RDP,
  or any arbitrary TCP/UDP service.

  - If service is not up, your service check fails.


## Keys to success
* Be comfortable using SSH
* [Be comfortable doing basic DNS troubleshooting](dns_basics.md)
* Ensure all of our hosts are using our DNS server.
* Be able to edit a zone file.
* Be able to add a new zone to our server
* [Query logging](query_logging.md)
* DNS-specific hardening
* General Linux hardening checklist
* DoS mitigations


## TODO
* IT DOESNT *HAVE* TO BE BIND!!!
* Example zone file
* Howtos for adding/editing hosts
* Alert on new/failed queries?
