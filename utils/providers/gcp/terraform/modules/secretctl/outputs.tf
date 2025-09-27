output "service_account_email" {
  value       = local.sa_email
  description = "Email of the service account bound to the custom role."
}

output "custom_role_name" {
  value       = "projects/${var.project_id}/roles/${google_project_iam_custom_role.this.role_id}"
  description = "Full name of the created custom role."
}
