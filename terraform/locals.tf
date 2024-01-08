locals {
  vultr_region  = "nrt"
  google_region = "asia-northeast1"

  service_name = "pleroma"
  github_repo  = "*"
  domain       = "social.p3ac0ck.net"
  admin_email  = "peacock0803sz@gmail.com"
  enviroment_variables = [
    {
      key   = "DOMAIN"
      value = local.domain
    },
    {
      key   = "ADMIN_NAME"
      value = "Peacock"
    },
    {
      key   = "ADMIN_EMAIL"
      value = local.admin_email
    },
    {
      key   = "NOTIFY_EMAIL"
      value = local.admin_email
    },
    {
      key   = "DB_PORT"
      value = "16751"
    },
    {
      key   = "DB_USER"
      value = "pleroma"
    },
  ]
  secrets = [
    "DB_PASS",
    "DB_HOST",
    "S3_BUCKET",
    "S3_ACCESS_KEY",
    "S3_SECRET_KEY"
  ]

  apis = [
    "artifactregistry.googleapis.com",
    "cloudapis.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "dns.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
    "serviceusage.googleapis.com",
  ]
  gha_roles = [
    "roles/artifactregistry.admin",
    "roles/cloudbuild.builds.builder",
    "roles/run.admin",
    "roles/iam.serviceAccountUser",
  ]
  cloud_run_roles = [
    "roles/run.admin",
    "roles/run.invoker",
    "roles/secretmanager.secretAccessor",
    "roles/secretmanager.viewer",
  ]
}
