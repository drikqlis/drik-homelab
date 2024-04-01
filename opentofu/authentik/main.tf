terraform {
  required_providers {
    onepassword = {
      source = "1Password/onepassword"
    }
    authentik = {
      source = "goauthentik/authentik"
    }
  }
}

provider "onepassword" {
  url = "https://onepassword.drik.it"
}

provider "authentik" {
  url = "https://auth.drik.it"
  token = data.onepassword_item.opentofu_authentik_secrets.section[index(data.onepassword_item.opentofu_authentik_secrets.section.*.label, "secrets")].field[index(data.onepassword_item.opentofu_authentik_secrets.section[index(data.onepassword_item.opentofu_authentik_secrets.section.*.label, "secrets")].field.*.label, "token")].value
}

data "onepassword_item" "opentofu_authentik_secrets" {
  vault = var.kube_vault
  title = "opentofu_authentik_secrets"
}

resource "authentik_user" "user" {
  for_each = var.authentik_users

  username = each.value.username
  email = each.value.email
  name = each.value.name
}

resource "authentik_group" "authentik_admins" {
  name = "authentik-admins"
  is_superuser = true
  users = [authentik_user.user["user1"].id, authentik_user.user["user2"].id]
}

resource "authentik_group" "jellyfin_admins" {
  name = "jellyfin-admins"
  users = [authentik_user.user["user1"].id, authentik_user.user["user2"].id]
}

resource "authentik_group" "jellyfin_users" {
  name = "jellyfin-users"
  users = values(authentik_user.user)[*].id
}

resource "authentik_group" "immich_users" {
  name = "immich-users"
  users = [authentik_user.user["user1"].id,
          authentik_user.user["user2"].id,
          authentik_user.user["user3"].id,
          authentik_user.user["user5"].id,
          authentik_user.user["user7"].id,
          authentik_user.user["user8"].id]
}

resource "authentik_group" "kube_apiserver_admins" {
  name = "kube-apiserver-admins"
  users = [authentik_user.user["user1"].id, authentik_user.user["user2"].id]
}
