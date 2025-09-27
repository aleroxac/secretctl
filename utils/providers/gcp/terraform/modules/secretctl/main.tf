terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

locals {
  # If the user passes a YAML path, extract includedPermissions from it;
  # otherwise, use the explicit list in var.role_permissions.
  _yaml           = var.role_permissions_yaml_path != null ? yamldecode(file(var.role_permissions_yaml_path)) : null
  yaml_perms      = local._yaml != null && contains(keys(local._yaml), "includedPermissions") ? local._yaml.includedPermissions : null
  effective_perms = coalesce(local.yaml_perms, var.role_permissions)

  sa_email = var.sa_create ? google_service_account.this[0].email : (var.sa_email != null
    ? var.sa_email
    : format("%s@%s.iam.gserviceaccount.com", var.sa_name, var.project_id)
  )
}

resource "google_service_account" "this" {
  count        = var.sa_create ? 1 : 0
  project      = var.project_id
  account_id   = var.sa_name
  display_name = var.sa_display_name != null ? var.sa_display_name : var.sa_name
  description  = var.sa_description
}

resource "google_project_iam_custom_role" "this" {
  project     = var.project_id
  role_id     = var.role_id
  title       = var.role_title
  description = var.role_description
  stage       = var.role_stage
  permissions = local.effective_perms

  # Optional: allow updating permissions freely
  # avoid_binary_authorization = true
}

# Bind the custom role to the service account
resource "google_project_iam_member" "sa_bind" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/${google_project_iam_custom_role.this.role_id}"
  member  = "serviceAccount:${local.sa_email}"
}

output "service_account_email" {
  value       = local.sa_email
  description = "Email of the service account bound to the custom role."
}

output "custom_role_name" {
  value       = "projects/${var.project_id}/roles/${google_project_iam_custom_role.this.role_id}"
  description = "Full name of the created custom role."
}
