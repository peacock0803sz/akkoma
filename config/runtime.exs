import Config

if config_env() == :prod do
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
end
