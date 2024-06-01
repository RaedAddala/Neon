# Live Streaming Platform Service

## How to Build and Use this Service

1. Clone this repository: `git clone https://github.com/RaedAddala/Live-Streaming-Service-with-Membrane-and-Elixir.git` or `git clone git@github.com:RaedAddala/Live-Streaming-Service-with-Membrane-and-Elixir.git`.
2. Make sure you have Elixir installed.
3. Run `mix deps.get` to install the dependencies.

***Next Two Steps are necessary to verify the server before running it!***
4. Compile your code with `cd live_streaming_platform_service` then `mix compile`.
5. Run tests with `mix test`.

***Finally, Serve!***
6. Run `mix phx.server`.
7. Open a stream using OBS or any other software that creates RTMP Streams and start streaming to the server.

For more informations about how to set up an RTMP Stream with OBS [check this out](RTMP_STREAM.MD).

## Best Practices

- Enforce the same coding style throughout the project by using the command `mix format`.
- Always Check tests with the command `mix test`.
