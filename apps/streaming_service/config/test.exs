import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :streaming_service, StreamingServiceWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "sN9+l8OAb2LqY1ad9FtlT5t0gBNf6LwVw7TtaWLXr6D3XRYARoXDsIPz5vvDR4F9",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
