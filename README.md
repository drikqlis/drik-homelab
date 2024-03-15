<div align="center">
<img src="files/drik-it-logo.svg" alt="drik-it-logo" width="500"/>

### ⚔️ Drik.IT Homelab 🛡️
💾 *GitOps, IaC, DevOps and all that fluff but in home.* 🏡

![GitHub last commit](https://img.shields.io/github/last-commit/drikqlis/drik-homelab?logo=github&style=for-the-badge&color=8060ff)

![Ansible](https://img.shields.io/badge/ansible-8060ff?style=for-the-badge&logo=ansible&logoColor=white&link=https%3A%2F%2Fwww.ansible.com%2F)
![Flux](https://img.shields.io/badge/flux-8060ff?style=for-the-badge&logo=flux&logoColor=white&link=https%3A%2F%2Ffluxcd.io%2F)
![OpenTofu](https://img.shields.io/badge/opentofu-8060ff?style=for-the-badge&logo=opentofu&logoColor=white&link=https%3A%2F%2Fopentofu.org%2F)
![Github Actions](https://img.shields.io/badge/github_actions-8060ff?style=for-the-badge&logo=github-actions&logoColor=white&link=https%3A%2F%2Fdocs.github.com%2Fen%2Factions)

![Kubernetes](https://img.shields.io/badge/kubernetes-8060ff?style=for-the-badge&logo=kubernetes&logoColor=white&link=https%3A%2F%2Fkubernetes.io%2F)
![Helm](https://img.shields.io/badge/helm-8060ff?style=for-the-badge&logo=helm&logoColor=white&link=https%3A%2F%2Fhelm.sh%2F)
![Arch Linux](https://img.shields.io/badge/arch_linux-8060ff?style=for-the-badge&logo=arch-linux&logoColor=white&link=https%3A%2F%2Farchlinux.org%2F)
![OpenZFS](https://img.shields.io/badge/openzfs-8060ff?style=for-the-badge&logo=openzfs&logoColor=white&color=8060ff&link=https%3A%2F%2Farchlinux.org%2F)


</div>

---

## 📔 Overview
This is a mono repository containing all the automations I use for my homelab spaning from kubernetes clusters, through baremetal KVM hosts, to personal computers and everything in between. I keep my infrastructure as code (IaC) and try to put GitOps into practice. I use tools like [Ansible](https://www.ansible.com), [Flux](https://fluxcd.io), [OpenTofu](https://opentofu.org) (Terraform fork), [Github Actions](https://docs.github.com/en/actions), [Kubernetes](https://kubernetes.io), [Helm](https://helm.sh) and more. All my machines use [Arch Linux](https://archlinux.org) as an operating system and [OpenZFS](https://openzfs.org) for storage.

## 🐧 Ansible
Ansible code resides in ansible directory (duh!) and is responsible for insalling, configuring and keeping up to date all of my baremetal servers, virtual machines and personal computers.

### Installation
My `install.yml` playbook can install (duh again!) Arch Linux from scrach using archiso and archzfs, configuring all the system components up to my liking (but it is still somewhat customizable). All my partitions are encrypted by default, I use systemd-boot with unified kernel image, SecureBoot, and ZFS for all storage including root. Install config diffres according to the type of machine (baremetal server, virtual machine, PC with nVIDIA GPU - they all need diffrent customizations).

### Configuration
Next is `configure.yml` that is responsible for, guess what, configuration of all the things. It gathers lots of roles, each one for specific app or zone of intrest. It is divided in four phases:
- **Basic configuration** - configuring all OS basics like network, ntp, package manager, firewall, NFS, additional storage, KVM etc.
- **GUI configuration** - responsible for installing and configuring KDE GUI and much needed apps for my PCs.
- **GUI personalization** - this one takes things to next level and personalizes KDE system apps and some others just how I like it, so I don't have to set anything in those pesky menus after reinstall.
- **Kubernetes installation** - for bootstraping my Kubernetes cluster and adding new nodes. I use kubeadm, cilium and kube-vip with BGP configured on my opnSense router for load-balancing. I know I could use kubespray but I wanted to learn, besides I use Arch and it is not supported.

## 🌍 OpenTofu (Terraform)
Currently I use OpenTofu for bootstraping Flux deployment into my Kubernetes cluster. I plan to add code for my Authentik instance. I would also like to create my VMs in libvirt using OpenTofu. I hope to implement this and more in near future.
- [x] Flux bootstraping
- [ ] Libvirt VM creation
- [ ] Authentik menagement

## ⛵ Kubernetes
I manage my Kubernetes cluster using Flux and Helm. For deployments that do not have charts created by the developer i create my own. They can be found in [drikqlis/drik-homelab-helm-charts](https://github.com/drikqlis/drik-homelab-helm-charts) repository. I generate my helm repository automatically using Github Actions.

### Core components
- [cert-manager](https://cert-manager.io/) - X.509 certificate management for Kubernetes.
- [Ingress-Nginx](https://kubernetes.github.io/ingress-nginx/) - ingress controller using NGINX as a reverse proxy and load balancer.
- [Cilium](https://cilium.io) - solution for providing, securing, and observing network connectivity between workloads.
- [CSI Driver NFS](https://github.com/kubernetes-csi/csi-driver-nfs) - NFS CSI driver for Kubernetes supporting dynamic provisioning of Persistent Volumes.
- [OpenEBS ZFS CSI Driver](https://github.com/openebs/zfs-localpv) - CSI driver for provisioning Local PVs backed by ZFS and more.
- [1Password Connect Kubernetes Operator](https://developer.1password.com/docs/k8s/k8s-operator) - integrates Kubernetes Secrets with 1Password Connect server.

### Flux
Flux is installed into `kubernetes/main/bootstrap` directory. There I have created dirs for helm repositories, namespaces and kustomizations for specific apps that point to files located in `kubernetes/main/apps/$appname` which contains helm release, configmap with values and OnePasswordItem kind which creates a secret with values that are secret. I have also created image automation to auto update image tag of specific helm releases when new version is built and published.

### Deployments
- [Authentik](https://goauthentik.io/) - used for SSO and identity management for all my services.
- [Kubernetes Dashboard](https://github.com/kubernetes/dashboard) - general purpose, web-based UI for Kubernetes cluster.
- [Jellyfin](https://jellyfin.org) - opensource Software Media System for all things media.
- [Vaultwarden](https://github.com/dani-garcia/vaultwarden) - unofficial Bitwarden compatible server written in Rust used for password management.
- [Dagonite Empire](https://github.com/KrystianKempski/DagoniteEmpire) - comprehensive tool for starting an online, text-based RPG campaign.