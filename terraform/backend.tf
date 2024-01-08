terraform {
  backend "gcs" {
    bucket = "peacock0803sz-pleroma-tfstate"
  }
}
