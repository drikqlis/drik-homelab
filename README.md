# Arch-Ansible-Install
Ansible playbooks for personalized Arch Linux install.

1. Clear Secure Boot keys and set it into setup mode.
2. Make sure UEFI and TPM is enabled and legacy boot disabled.
3. Boot into Arch install ISO.
4. Set root password using `passwd` command.
5. Restart the ssh service using `systemctl restart sshd` command.
6. Generate user password hash using `mkpasswd --method=sha-512` on any Debian based distro.
7. Create crypt_vars.yml from example file and encrypt using `ansible-vault edit group_vars/all/crypt_vars.yml` command.
8. Run installation playbook using `ansible-playbook install.yml -k --ask-vault-pass` command.
9. Run post installation playbook using `ansible-playbook post_install.yml --ask-vault-pass` command.
10. You can run select roles by editing select_role.yml playbook and using `ansible-playbook select_role.yml --ask-vault-pass` command.
