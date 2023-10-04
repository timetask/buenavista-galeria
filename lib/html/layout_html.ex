defmodule Galeria.HTML.Layout do
  use Phoenix.Component

  import Phoenix.Controller,
    only: [get_csrf_token: 0]

  def galeria_css_url(conn) do
    prefix = conn.private.phoenix_router.__galeria_url_prefix__()
    Path.join(prefix, "/static/css/galeria.css")
  end

  def current_galeria_theme_url(conn) do
    prefix = conn.private.phoenix_router.__galeria_url_prefix__()
    Path.join(prefix, "/static/themes/#{conn.assigns.galeria_theme_name}.css")
  end

  def js_url(conn) do
    prefix = conn.private.phoenix_router.__galeria_url_prefix__()
    Path.join(prefix, "/static/js/galeria.js")
  end

  embed_templates "layout/*"
end
