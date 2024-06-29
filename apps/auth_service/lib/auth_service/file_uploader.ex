defmodule AuthService.FileUploader do
  def upload_file(upload, upload_dir) do
    extension = Path.extname(upload.filename)

    filename =
      Integer.to_string(:rand.uniform(4_294_967_296), 32) <>
        Integer.to_string(:rand.uniform(4_294_967_296), 32)

    File.cp(
      upload.path,
      upload_dir <> "/#{filename}#{extension}"
    )

    "#{filename}#{extension}"
  end
end
