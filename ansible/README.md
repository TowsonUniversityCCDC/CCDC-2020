# Ansible Configuration Management

## Instructions

For initial setup, run `scripts/bootstrap.sh`.
This installs Ansible and the required roles for each playbook.

To run a playbook, use the command `ansible-playbook -i inventory <playbook>.yml`.

## Playbooks

### main.yml

Default playbook. Runs OS and SSH hardening roles.

## Roles

## dev-sec.os-hardening

https://galaxy.ansible.com/dev-sec/os-hardening

## dev-sec.ssh-hardening

https://galaxy.ansible.com/dev-sec/ssh-hardening
