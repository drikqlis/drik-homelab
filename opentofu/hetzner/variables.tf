variable "hcloud_token" {
  sensitive = true
  type = string
}

variable "mk_ssh_key" {
  type = string
}

variable "ssh_port" {
  type = string
}

variable "ssh_source_ips" {
  type = list(string)
}

variable "vps_1_ptr_record" {
  type = string
}
