import Config

# Print only warnings and errors during test
config :logger, level: :warning

# In test we don't send emails.
# We don't run a server during test. If one is required,
# you can enable the server option below.
config :parallel_sum_gui, ParallelSumGui.Mailer, adapter: Swoosh.Adapters.Test

config :parallel_sum_gui, ParallelSumGuiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Q0zu+ryqqq8qFAHvwBawZlKQ1vdHBdm+BqZuwB0yMRgUyZRKEaS1wjoElT/20sYs",
  server: false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  # Enable helpful, but potentially expensive runtime checks
  enable_expensive_runtime_checks: true

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false
