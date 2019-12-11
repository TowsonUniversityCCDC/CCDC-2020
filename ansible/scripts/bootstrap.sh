#!/usr/bin/env bash
set -e

function install_ansible_debian() {
    set -x
    sudo echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" \
	      >> /etc/apt/sources.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
    sudo apt update
    sudo apt install ansible
}

function install_ansible_pip() {
    echo "It is suggested to install from within a virtualenv"
    echo "Abort if pip isn't installed on your system"
    read -p "Press any key to continue; abort with CTRL-C"

    set -x
    pip install --user ansible
}

function install_ansible_ubuntu() {
    set -x
    sudo apt update
    sudo apt install software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible
}

function install_roles() {
    for reqs in requirements/*.yml; do
        ansible-galaxy install -r "$reqs"
    done
}


echo "$0 -- installs Ansible and each required role"
echo ""
echo "If your OS is not supported, see the following for instructions:"
echo "https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html"
echo ""
echo "Which OS are you running?"
echo "[1] Ubuntu"
echo "[2] Debian"
echo "[3] Alternative: install with pip (macOS)"

installer=''

while true; do
    read -p "Choice: " os
    case $os in
        1 ) installer=install_ansible_ubuntu; break;;
	2 ) installer=install_ansible_debian; break;;
	3 ) installer=install_ansible_pip; break;;
	* ) echo "No OS selected. Exiting."; exit; break;;
    esac
done

# Change CWD to Ansible subdirectory
cd "$(dirname "$0")/.."

# Run OS-specific installation steps
"$installer"

# Install required roles for Ansible playbook(s)
install_roles
