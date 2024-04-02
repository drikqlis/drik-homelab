resource "authentik_user" "user" {
  for_each = var.authentik_users

  username = each.value.username
  email = each.value.email
  name = each.value.name
}

resource "authentik_group" "authentik_admins" {
  name = "authentik-admins"
  is_superuser = true
  users = [authentik_user.user["user1"].id,
          authentik_user.user["user2"].id]
}

resource "authentik_group" "jellyfin_admins" {
  name = "jellyfin-admins"
  users = [authentik_user.user["user1"].id,
          authentik_user.user["user2"].id]
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
  users = [authentik_user.user["user1"].id,
          authentik_user.user["user2"].id]
}
