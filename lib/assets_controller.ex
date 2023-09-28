defmodule Galeria.AssetsController do
  import Plug.Conn

  def init(asset) when asset in [:css, :js, :themes, :svg], do: asset

  def call(conn, asset) do
    filename = conn.path_params["path"]
    current_dir = Path.dirname(__ENV__.file)
    file_path = Path.expand(current_dir <> "/../priv/static/#{asset}/" <> filename)
    content = File.read!(file_path)

    conn
    |> put_resp_header("content-type", content_type(asset))
    |> put_private(:plug_skip_csrf_protection, true)
    |> send_resp(200, content)
    |> halt()
  end

  defp content_type(:css), do: "text/css"
  defp content_type(:js), do: "text/javascript"
  defp content_type(:themes), do: "text/css"
  defp content_type(:svg), do: "image/svg+xml"
end
