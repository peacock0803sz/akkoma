resource "google_iam_workload_identity_pool" "pool" {
  workload_identity_pool_id = "github"
  display_name              = "GitHub"
  description               = "GitHub Identity Pool for CI"
}

resource "google_iam_workload_identity_pool_provider" "provider" {
  project                            = data.google_project.project.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "actions"
  display_name                       = "GitHub"
  description                        = "GitHub Identity Pool Provider for CI"

  attribute_mapping = {
    "google.subject" = "assertion.sub"
  }
  oidc {
    issuer_uri =  "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account" "service_account_gha" {
  account_id   = "github-actions"
  display_name = "GitHub Actions Service Account"
}

resource "google_project_iam_member" "build" {
  for_each = toset(local.gha_roles)

  role    = each.value
  project = data.google_project.project.project_id
  member  = "serviceAccount:${google_service_account.service_account_gha.email}"
}

resource "google_service_account_iam_member" "binding" {
  service_account_id = google_service_account.service_account_gha.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.pool.name}/${local.github_repo}"
}
