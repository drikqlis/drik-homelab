# Arch-Ansible-Install

Ansible playbooks for personalized Arch Linux install.

 1. Clear Secure Boot keys and set it into setup mode.
 2. Make sure UEFI and TPM is enabled and legacy boot disabled.
 3. Boot into Arch install ISO.
 4. Set root password using `passwd` command.
 5. Restart the ssh service using `systemctl restart sshd` command.
 6. Generate user password hash using `mkpasswd --method=sha-512` on any Debian based distro.
 7. Create and encrypt host variables from example file.
 8. Add host to inventory.
 9. Copy kdewallet.salt and kdewallet.kwl from `/home/{{ user_name }}/.local/share/kwalletd` to `roles/kdewallet/files` and rename them to `{{ user-name }}-kdewallet.salt/kwl` if importing from previous installation.
10. Copy remmina connections from `/home/{{ user_name }}/.local/share/remmina/` to `roles/remmina/files/{{ user_name }}-connections/`
11. Run installation playbook using `ansible-playbook install.yml -k --extra-vars "@hostname.yml"` command.
12. Enter passphrase to unlock system and wait for it to boot. It may be needed to clear DNS cache on Ansible machine using `resolvectl flush-caches`.
13. Run post installation playbook using `ansible-playbook post_install.yml -l hostname` command.
14. You can run select roles by running coresponding tags, for example: `ansible-playbook post_install.yml -t sddm -l hostname`.
