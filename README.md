# Arch-Ansible-Install
Ansible playbooks to install Arch Linux.

1. Clear Secure Boot keys and set it into setup mode.
2. Make sure UEFI and TPM is enabled and legacy boot disabled.
3. Boot into Arch install ISO.
4. Set root password using `passwd` command.
5. Restart the ssh service using `systemctl restart sshd` command.
6. Run installation playbook using `ansible-playbook install.yml -k --ask-vault-pass` command.
