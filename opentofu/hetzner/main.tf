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
  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "80"
    description = "http"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "443"
    description = "https"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "25"
    description = "smtp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "465"
    description = "smtps"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "587"
    description = "submission"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "143"
    description = "imap"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "993"
    description = "imaps"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "110"
    description = "pop3"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "995"
    description = "pop3s"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "4190"
    description = "managesieve"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_primary_ip" "vps_1_primary_ip" {
name          = "vps-1-primary-ip"
datacenter    = "hel1-dc2"
type          = "ipv4"
assignee_type = "server"
auto_delete   = false
}

resource "hcloud_server" "vps_1" {
  name         = "vps-1"
  image        = "rocky-9"
  iso          = "111971"
  server_type  = "cx32"
  firewall_ids = [hcloud_firewall.vps_1_firewall.id]
  datacenter   = "hel1-dc2"
  backups      = true
  ssh_keys     = [hcloud_ssh_key.mk_ssh_key.id]
  public_net {
    ipv4_enabled = true
    ipv4 = hcloud_primary_ip.vps_1_primary_ip.id
    ipv6_enabled = false
  }
}

resource "hcloud_rdns" "vps_1_ptr" {
  server_id  = hcloud_server.vps_1.id
  ip_address = hcloud_server.vps_1.ipv4_address
  dns_ptr    = var.vps_1_ptr_record
}
