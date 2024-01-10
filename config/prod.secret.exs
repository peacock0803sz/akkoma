import Config

config :pleroma, Pleroma.Web.Endpoint,
  url: [host: "social.p3ac0ck.net", scheme: "https", port: 443],
  http: [ip: {0, 0, 0, 0}, port: 8080]

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
  username: System.fetch_env!("DB_USER"),
  password: System.fetch_env!("DB_PASS"),
  database: System.fetch_env!("DB_NAME"),
  hostname: System.fetch_env!("DB_HOST"),
  port: System.fetch_env!("DB_PORT"),
  pool_size: 10,
  ssl: true,
  ssl_opts: [verify: :verify_none],
  connect_timeout: 60_000

config :ex_aws, :s3,
  # We have to set dummy profile to use web identity adapter.
  # So this profile does not exist and don't prepare it.
  secret_access_key: System.fetch_env!("S3_ACCESS_KEY"),
  access_key_id: System.fetch_env!("S3_SECRET_KEY"),
  awscli_auth_adapter: ExAws.STS.AuthCache.AssumeRoleWebIdentityAdapter,
  region: System.fetch_env!("S3_REGION"),
  scheme: "https://"

config :pleroma, :instance, static_dir: "/var/lib/pleroma/static"

config :pleroma, Pleroma.Upload,
  uploader: Pleroma.Uploaders.S3,
  base_url: "https://media.social.p3ac0ck.net"

config :pleroma, :shout, enabled: false

config :pleroma, :frontend_configurations,
  pleroma_fe: %{
    showInstanceSpecificPanel: true,
    scopeOptionsEnabled: false,
    webPushNotifications: true
  }

config :pleroma, Oban, log: :debug

config :logger,
  backends: [:console]

# MetricsExport will not read env when runtime
# So I want to use runtime.exs instead of Mix.Config, but it is not supported, so I'm waiting.
# config :prometheus, Pleroma.Web.Endpoint.MetricsExporter,
#   enabled: true,
#   auth: {:basic, System.fetch_env!("METRICS_USER"), System.fetch_env!("METRICS_PASSWORD")},
#   ip_whitelist: [],
#   path: "/api/pleroma/app_metrics",
#   format: :text
