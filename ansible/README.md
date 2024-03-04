<div align="center">
<img src="files/drik-it-logo.svg" alt="drik-it-logo" width="500"/>
 
### Drik.IT Homelab

![GitHub last commit](https://img.shields.io/github/last-commit/drikqlis/drik-homelab?logo=github&style=for-the-badge)
</div>

---

Ansible playbooks for personalized Arch Linux install.

 1. Clear Secure Boot keys and set it into setup mode.
 2. Make sure UEFI and TPM is enabled and legacy boot disabled.
 3. Boot into Arch install ISO.
 4. Set root password using `passwd` command.
 5. Restart the ssh service using `systemctl restart sshd` command.
 6. Create and encrypt host variables from example file.
 7. Add host to inventory.
 8. Copy kdewallet.salt and kdewallet.kwl from `/home/{{ user_name }}/.local/share/kwalletd` to `files/users/{{ user_name }}` if importing from previous installation.
 9. Copy remmina connections from `/home/{{ user_name }}/.local/share/remmina/` to `files/users/{{ user_name }}/remmina` if importing from previous installation.
10. Run installation playbook using `ansible-playbook install.yml -vD -k --extra-vars "@host_vars/{{ hostname }}.yml"` command.
11. Enter passphrase to unlock system and wait for it to boot. It may be needed to clear DNS cache on Ansible machine using `resolvectl flush-caches`.
12. Run post installation playbook using `ansible-playbook configure.yml -vD -l {{ hostname }}` command.
13. You can run select roles by running coresponding tags, for example: `ansible-playbook configure.yml -vD -t sddm -l hostname`.
