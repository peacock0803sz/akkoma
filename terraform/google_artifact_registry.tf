resource "google_artifact_registry_repository" "repo" {
  format        = "DOCKER"
  location      = local.google_region
  repository_id = local.service_name
}
