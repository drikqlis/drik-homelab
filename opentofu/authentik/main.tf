terraform {
  required_providers {
    onepassword = {
      source = "1Password/onepassword"
      version = "1.4.3"
    }
    authentik = {
      source = "goauthentik/authentik"
    }
  }
}

provider "onepassword" {
  url = var.onepassword_url
  token = var.onepassword_token
}

provider "authentik" {
  url = var.authentik_url
  token = data.onepassword_item.opentofu_authentik_secrets.section[index(data.onepassword_item.opentofu_authentik_secrets.section.*.label, "secrets")].field[index(data.onepassword_item.opentofu_authentik_secrets.section[index(data.onepassword_item.opentofu_authentik_secrets.section.*.label, "secrets")].field.*.label, "token")].value
}

data "onepassword_item" "opentofu_authentik_secrets" {
  vault = var.onepassword_vault
  title = "opentofu_authentik_secrets"
}
