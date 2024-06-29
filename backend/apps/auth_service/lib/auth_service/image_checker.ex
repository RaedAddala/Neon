defmodule ImageChecker do
  def is_image?(file) do
    mime_type = MIME.from_path(file.filename)

    cond do
      String.match?(mime_type, ~r{^image/}) ->
        true

      true ->
        false
    end
  end
end
