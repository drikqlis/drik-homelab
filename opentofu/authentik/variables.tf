variable "kube_vault" {
  type = string
}

variable "authentik_users" {
  type = map(object({
    username = string
    email = string
    name = string
  }))
  default = {
    user1 = {
      username = "user1"
      email = "user1@email.com"
      name = "user1"
    }
    user2 = {
      username = "user2"
      email = "user2@email.com"
      name = "user2"
    }
    user3 = {
      username = "user3"
      email = "user3@email.com"
      name = "user3"
    }
  }
}