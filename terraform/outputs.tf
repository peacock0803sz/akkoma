output "github_actions_workload_identity_pool_provider_name" {
  value = google_iam_workload_identity_pool.pool.name
}

output "github_actions_workload_identity_pool_service_account_email" {
  value = google_service_account.service_account_gha.email
}
