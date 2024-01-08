resource "google_compute_global_address" "addr" {
  name = "${local.service_name}-address"
}
output "external_ip" {
  value = google_compute_global_address.addr.address
}

resource "google_compute_managed_ssl_certificate" "cert" {
  name = "${local.service_name}-cert"
  managed {
    domains = [local.domain]
  }
}

resource "google_compute_region_network_endpoint_group" "neg" {
  name                  = "${local.service_name}-neg"
  network_endpoint_type = "SERVERLESS"
  region                = local.google_region
  cloud_run {
    service = google_cloud_run_v2_service.service.name
  }
}

resource "google_compute_backend_service" "default" {
  name = "${local.service_name}-backend"

  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 30

  backend {
    group = google_compute_region_network_endpoint_group.neg.id
  }
}

resource "google_compute_url_map" "urlmap" {
  name = "${local.service_name}-urlmap"

  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_https_proxy" "default" {
  name = "${local.service_name}-https-proxy"

  url_map = google_compute_url_map.urlmap.id
  ssl_certificates = [
    google_compute_managed_ssl_certificate.cert.id
  ]
}

resource "google_compute_global_forwarding_rule" "lb" {
  name = "${local.service_name}-lb"

  target     = google_compute_target_https_proxy.default.id
  port_range = "443"
  ip_address = google_compute_global_address.addr.address
}

resource "google_compute_url_map" "https_redirect" {
  name = "${local.service_name}-https-redirect"

  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}

resource "google_compute_target_http_proxy" "https_redirect" {
  name    = "${local.service_name}-http-proxy"
  url_map = google_compute_url_map.https_redirect.id
}

resource "google_compute_global_forwarding_rule" "https_redirect" {
  name = "${local.service_name}-lb-http"

  target     = google_compute_target_http_proxy.https_redirect.id
  port_range = "80"
  ip_address = google_compute_global_address.addr.address
}
