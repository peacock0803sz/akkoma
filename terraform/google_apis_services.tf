data "google_project" "project" {}

resource "google_project_service" "api" {
  for_each                   = toset(local.apis)
  service                    = each.value
  project                    = data.google_project.project.project_id
  disable_on_destroy         = false
  disable_dependent_services = false

  lifecycle {
    # NOTE: これをtrueにするとdestroy時にエラーになるため、誤って削除されないように気がつける
    prevent_destroy = false
  }
}

resource "time_sleep" "wait" {
  create_duration = "5m"

  depends_on = [google_project_service.api]
}
