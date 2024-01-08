provider "random" {}

provider "google" {
  project = var.google_project
  region  = local.google_region
}

provider "vultr" {}

terraform {
  required_version = "~> 1.5.0"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.79.0"
    }
    vultr = {
      source  = "vultr/vultr"
      version = "~> 2.17.1"
    }
  }
}
