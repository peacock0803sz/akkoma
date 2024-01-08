resource "google_service_account" "service_account_run" {
  account_id   = local.service_name
  display_name = local.service_name
}

resource "google_project_iam_member" "iam_binding" {
  for_each = toset(local.cloud_run_roles)

  project = data.google_project.project.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.service_account_run.email}"
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_v2_service" "service" {
  name     = local.service_name
  location = local.google_region

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      dynamic "env" {
        for_each = local.enviroment_variables
        content {
          name  = env.value["key"]
          value = env.value["value"]
        }
      }
      dynamic "env" {
        for_each = toset(local.secrets)
        content {
          name = env.value
          value_source {
            secret_key_ref {
              secret  = google_secret_manager_secret.secrets[env.value].secret_id
              version = "latest"
            }
          }
        }
      }
    }
    service_account = google_service_account.service_account_run.email
  }

  lifecycle {
    ignore_changes = [
      client,
      client_version,
      labels,
      template[0].labels,
      template[0].containers[0].image,
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "policy" {
  project     = data.google_project.project.project_id
  location    = local.google_region
  name        = google_cloud_run_v2_service.service.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
