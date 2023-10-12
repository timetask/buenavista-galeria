defmodule Galeria.Plugs.CurrentThemePlug do
  def init(opts), do: opts

  def call(conn, _opts) do
    case Plug.Conn.get_session(conn, :galeria_theme_name) do
      theme_name when is_binary(theme_name) ->
        conn

      _ ->
        {:ok, theme} = Galeria.GaleriaConfig.get_default_theme()
        Plug.Conn.put_session(conn, :galeria_theme_name, theme.name)
    end
  end
end
