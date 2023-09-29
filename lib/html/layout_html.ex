defmodule Galeria.HTML.Layout do
  use Phoenix.Component

  import Phoenix.Controller,
    only: [get_csrf_token: 0]

  embed_templates("layout/*")

  def galeria_css_url(conn) do
    prefix = conn.private.phoenix_router.__galeria_url_prefix__()
    Path.join(prefix, "/css/galeria.css")
  end

  def current_theme_url(conn) do
    prefix = conn.private.phoenix_router.__galeria_url_prefix__()
    Path.join(prefix, "/themes/#{conn.assigns.theme_name}.css")
  end

  def js_url(conn) do
    prefix = conn.private.phoenix_router.__galeria_url_prefix__()
    Path.join(prefix, "/js/galeria.js")
  end
end
