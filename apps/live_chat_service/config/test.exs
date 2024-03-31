import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :live_chat_service, LiveChatServiceWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "d7shcA1gdxQl2PsY4qXvatVO0S2fWCn5hWRrPBblErSU4CQRr01czqVseZD1BwhS",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
