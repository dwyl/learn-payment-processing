import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :app, AppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base:
    "lrn6ftfPZu7KSTQ54v4foc/gq2FgYfB9/ckQw+Hhi/NNcUM7nf/mUlTqZWJOXAoK",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Don't worry, this AUTH_API_KEY is NOT valid.
# It's just for ensuring it passes on GitHub CI
# see: github.com/dwyl/mvp/issues/258
config :auth_plug,
  api_key:
    "2PzB7PPnpuLsbWmWtXpGyI+kfSQSQ1zUW2Atz/+8PdZuSEJzHgzGnJWV35nTKRwx/authdemo.fly.dev"
