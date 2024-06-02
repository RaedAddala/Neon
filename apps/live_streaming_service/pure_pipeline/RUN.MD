# How to Run this Pipeline

1. Run `mix deps.get`.
2. Make sure **inotify-tools** is installed. On Debian based Distros, Run `sudo apt-get install inotify-tools`.
3. Run `mix assets.deploy`.
4. Run `mix phx.server` to start Server: The server will be waiting for an RTMP stream on `localhost:9006`, and the client of the application will be available on `localhost:4000`.
5. Then Set the RTMP stream using an encoder.

## Using OBS As an Encoder

You can send RTMP stream onto `localhost:<PORT>` with your favorite streaming tool.

Here is how to generate an RTMP stream with [OBS](https://obsproject.com).

Once you have OBS installed, you can perform the following steps:

1. Open the OBS application
2. Open the `Settings` windows
3. Go to the `Stream` tab, set `Service` to `Custom...` and then set the value in the `Server` field to `rtmp://localhost:9006` (the address where the server is waiting for the stream)
4. Go to the `Output`, set output mode to `Advanced`, and set `Keyframe Interval` to 2 seconds.
5. Finally, you can go back to the main window and start streaming with the `Start Streaming` button.
