defmodule Galeria.CurrentThemePlug do
  def init(opts), do: opts

  def call(conn, _opts) do
    theme =
      if theme_name = conn.query_params["theme"] do
        case Galeria.Config.find_theme(theme_name) do
          {:ok, theme} -> theme
          {:error, :not_found} -> Galeria.Config.get_default_theme()
        end
      else
        with theme_name when is_binary(theme_name) <- Plug.Conn.get_session(conn, :theme_name),
             {:ok, theme} <- Galeria.Config.find_theme(theme_name) do
          theme
        else
          _ ->
            Galeria.Config.get_default_theme()
        end
      end

    conn
    |> Plug.Conn.put_session(:theme_name, theme.name)
    |> Plug.Conn.assign(:theme, theme)
  end
end
