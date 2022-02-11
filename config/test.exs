import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :book_store, BookStore.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "book_store_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :book_store, BookStoreWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "SoOaAzUCLRSbuP65ATFHzly1dA/OA1S3/8x92IS069/NWxNzv4wf8GenCoiKqV9K",
  server: false

# In test we don't send emails.
config :book_store, BookStore.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
