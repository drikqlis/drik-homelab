variable "github_token" {
  sensitive = true
  type      = string
}

variable "github_user" {
  type = string
}

variable "github_repository" {
  type = string
}

variable "cluster_domain" {
  type = string
}
