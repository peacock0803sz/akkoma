resource "vultr_object_storage" "storage" {
  provider = vultr

  cluster_id = 4
  label      = "${local.service_name}-media"
}

output "S3_ACCESS_KEY" {
  value     = vultr_object_storage.storage.s3_access_key
  sensitive = true
}
output "S3_SECRET_KEY" {
  value     = vultr_object_storage.storage.s3_secret_key
  sensitive = true
}
output "S3_REGION" {
  value = vultr_object_storage.storage.s3_hostname
}
