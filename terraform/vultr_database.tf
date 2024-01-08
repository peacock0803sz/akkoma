resource "random_password" "db_password" {
  length  = 32
  special = false
}

resource "vultr_database" "database" {
  provider = vultr

  database_engine         = "pg"
  database_engine_version = "13"
  region                  = local.vultr_region
  plan                    = "vultr-dbaas-hobbyist-cc-1-25-1"
  label                   = local.service_name
  tag                     = ""
  cluster_time_zone       = "Asia/Tokyo"
  maintenance_dow         = "monday"
  maintenance_time        = "00:00"
}

resource "vultr_database_user" "user" {
  provider = vultr

  database_id = vultr_database.database.id
  username    = local.service_name
  password    = random_password.db_password.result
}

output "DB_HOST" {
  value = vultr_database.database.host
}
output "DB_USER" {
  value = vultr_database_user.user.username
}
output "DB_PASS" {
  value     = random_password.db_password.result
  sensitive = true
}

resource "vultr_database_db" "db" {
  provider = vultr

  database_id = vultr_database.database.id
  name        = local.service_name
}
