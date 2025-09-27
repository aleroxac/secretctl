variable "project_id" {
  type        = string
  description = "GCP project ID."
}

# Service Account controls
variable "sa_create" {
  type        = bool
  default     = false
  description = "Whether to create the service account. If false, provide sa_email or sa_name."
}

variable "sa_name" {
  type        = string
  default     = "secretctl-cli"
  description = "Service account account_id (used if sa_create=true or to infer email if sa_email is null)."
}

variable "sa_email" {
  type        = string
  default     = null
  description = "Existing service account email. If null and sa_create=false, it will be inferred from sa_name + project_id."
}

variable "sa_display_name" {
  type        = string
  default     = null
  description = "Display name for the SA (when creating)."
}

variable "sa_description" {
  type        = string
  default     = "Service account for Secretctl CLI."
  description = "Description for the SA (when creating)."
}

# Custom Role controls
variable "role_id" {
  type        = string
  default     = "SecretctlCli"
  description = "Custom role id (suffix in projects/{project}/roles/{role_id})."
}

variable "role_title" {
  type        = string
  default     = "Secret Manager CLI"
  description = "Title of the custom role."
}

variable "role_description" {
  type        = string
  default     = "Minimal permissions for a CLI to list/create/update/delete secrets and enable/disable versions."
  description = "Description for the custom role."
}

variable "role_stage" {
  type        = string
  default     = "GA"
  description = "Stage of the custom role (ALPHA, BETA, GA, DEPRECATED)."
}

variable "role_permissions" {
  type        = list(string)
  default     = [
    # Secrets
    "secretmanager.secrets.list",
    "secretmanager.secrets.get",
    "secretmanager.secrets.create",
    "secretmanager.secrets.update",
    "secretmanager.secrets.delete",
    # "secretmanager.secrets.undelete",
    # Versions
    "secretmanager.versions.list",
    "secretmanager.versions.get",
    "secretmanager.versions.access",
    "secretmanager.versions.add",
    "secretmanager.versions.enable",
    "secretmanager.versions.disable"
    # "secretmanager.versions.destroy",
  ]
  description = "List of permissions for the custom role. Ignored if role_permissions_yaml_path is set with includedPermissions."
}

variable "role_permissions_yaml_path" {
  type        = string
  default     = null
  description = "Path to a YAML file (same shape as gcloud --file) containing includedPermissions. If provided, overrides role_permissions."
}