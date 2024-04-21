#!/bin/bash

fedora() {
    sudo dnf install -y ansible
}

ubuntu() {
    sudo apt update
    sudo apt install -y ansible
}

macos() {
    brew install ansible
}

OS="$(uname -s)"
case "${OS}" in
    Linux*)
        if [ -f /etc/fedora-release ]; then
            fedora
        elif [ -f /etc/lsb-release ]; then
            ubuntu
        else
            echo "Ukjent distro"
            exit 1
        fi
        ;;
    Darwin*)
        macos
        ;;
    *)
        echo "Ukjent OS: ${OS}"
        exit 1
        ;;
esac


ansible-playbook ~/.bootstrap/setup.yml --ask-become-pass

echo "Ansible installed."
