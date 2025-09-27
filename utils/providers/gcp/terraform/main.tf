terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

module "secretctl_cli_role" {
  source = "modules/secretctl"

  project_id = var.project_id

  # Use an EXISTING service account email (recommended if you already created it elsewhere):
  sa_create = false
  sa_email  = var.sa_email

  # Or, if you prefer to create the SA here, set:
  # sa_create = true
  # sa_name   = "secretctl-cli"
  # sa_display_name = "Secretctl CLI SA"

  # Option A: inline permissions (defaults already set to Secret Manager minimal ops)
  # role_permissions = [
  #   "secretmanager.secrets.list",
  #   "secretmanager.secrets.get",
  #   "secretmanager.secrets.create",
  #   "secretmanager.secrets.update",
  #   "secretmanager.secrets.delete",
  #   "secretmanager.versions.list",
  #   "secretmanager.versions.get",
  #   "secretmanager.versions.add",
  #   "secretmanager.versions.enable",
  #   "secretmanager.versions.disable",
  # ]

  # Option B: load from YAML (same shape used by gcloud --file):
  # role_permissions_yaml_path = "${path.module}/role-permissions.yaml"

  role_id          = "SecretctlCli"
  role_title       = "Secret Manager CLI"
  role_description = "Minimal permissions for a CLI to manage secrets and versions."
  role_stage       = "GA"
}

variable "project_id" {
  type = string
}

variable "sa_email" {
  type        = string
  description = "Existing service account email (e.g., my-sa@PROJECT_ID.iam.gserviceaccount.com)"
}

output "sa_email" {
  value = module.secretctl_cli_role.service_account_email
}

output "custom_role_name" {
  value = module.secretctl_cli_role.custom_role_name
}