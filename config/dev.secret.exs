import Config

config :pleroma, Pleroma.Web.Endpoint,
  url: [host: "localhost", scheme: "http", port: 80],
  http: [
    ip: {0, 0, 0, 0},
    port: 4000,
    protocol_options: [max_request_line_length: 8192, max_header_value_length: 8192]
  ],
  protocol: "http",
  debug_errors: true,
  code_reloader: false,
  check_origin: false,
  watchers: [],
  secure_cookie_flag: false

config :pleroma, Pleroma.Emails.Mailer, adapter: Swoosh.Adapters.Local

config :pleroma, :instance,
  name: "Peacock's Nesting Box",
  email: "peacock0803sz@gmail.com",
  notify_email: "peacock0803sz@gmail.com",
  limit: 5000,
  registrations_open: false,
  federating: true,
  healthcheck: true

config :pleroma, Pleroma.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "pleroma",
  password: "ChangeMe!",
  database: "pleroma",
  hostname: "db",
  port: 5432,
  pool_size: 10,
  timeout: 60_000

config :pleroma, :instance, static_dir: "/var/lib/pleroma/static"

config :pleroma, :shout, enabled: false

# MetricsExport will not read env when runtime
# So I want to use runtime.exs instead of Mix.Config, but it is not supported, so I'm waiting.
# config :prometheus, Pleroma.Web.Endpoint.MetricsExporter,
#   enabled: true,
#   auth: {:basic, System.fetch_env!("METRICS_USER"), System.fetch_env!("METRICS_PASSWORD")},
#   ip_whitelist: [],
#   path: "/api/pleroma/app_metrics",
#   format: :text
