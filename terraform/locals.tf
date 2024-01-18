locals {
  vultr_region  = "nrt"
  google_region = "asia-northeast1"

  service_name = "pleroma"
  github_repo  = "*"
  domain       = "social.p3ac0ck.net"
  enviroment_variables = [
    {
      key   = "DB_NAME"
      value = "pleroma"
    },
    {
      key   = "DB_PORT"
      value = "16751"
    },
    {
      key   = "DB_USER"
      value = "pleroma"
    },
    {
      key   = "S3_REGION"
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
