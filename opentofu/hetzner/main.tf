terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_ssh_key" "mk_ssh_key" {
  name       = "mk_ssh_key"
  public_key = var.mk_ssh_key
}

resource "hcloud_firewall" "vps_1_firewall" {
  name = "vps_1_firewall"
  rule {
    direction   = "in"
    protocol    = "icmp"
    description = "ping"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = var.ssh_port
    source_ips  = var.ssh_source_ips
    description = "ssh"
  }

}

resource "hcloud_server" "vps_1" {
  name         = "vps-1"
  image        = "rocky-9"
  iso          = "111971"
  server_type  = "cx32"
  firewall_ids = [hcloud_firewall.vps_1_firewall.id]
  location     = "fsn1"
  backups      = true
  ssh_keys     = [hcloud_ssh_key.mk_ssh_key.id]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
}