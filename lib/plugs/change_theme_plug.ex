defmodule Galeria.Plugs.ChangeThemePlug do
  def init(opts), do: opts

  def call(conn, :change_theme) do
    theme_name = conn.path_params["theme_name"]

    {:ok, theme} =
      case Galeria.Config.find_theme(theme_name) do
        {:ok, theme} -> {:ok, theme}
        {:error, :not_found} -> Galeria.Config.get_default_theme()
      end

    {_, redirect_to} = List.keyfind(conn.req_headers, "referer", 0, "/dev/galeria")
    [_, redirect_to] = String.split(redirect_to, conn.host)

    conn
    |> Plug.Conn.put_session(:galeria_theme_name, theme.name)
    |> Phoenix.Controller.redirect(to: redirect_to)
  end
end
