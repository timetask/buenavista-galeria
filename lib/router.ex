defmodule Galeria.Router do
  defmacro galeria_routes(path) do
    quote bind_quoted: [path: path] do
      scope path, alias: false, as: false do
        import Plug.Builder, only: [plug: 2]
        import Phoenix.LiveView.Router, only: [live: 3, live_session: 3]
        import Phoenix.Router, only: [get: 3, pipe_through: 1, scope: 2, scope: 3]

        pipe_through Galeria.CurrentThemePlug

        live_session :galeria, root_layout: {Galeria.HTML.Layout, :root} do
          live "/", Galeria.GaleriaLive, :index
          live "/ensambles/:ensamble_name", Galeria.GaleriaLive, :ensamble
          live "/component/:component_name", Galeria.GaleriaLive, :component
        end

        scope "/static" do
          get "/css/:path", Galeria.AssetsController, :css
          get "/js/:path", Galeria.AssetsController, :js
          get "/themes/:path", Galeria.AssetsController, :themes
        end

        unless Module.get_attribute(__MODULE__, :galeria_url_prefix) do
          @galeria_url_prefix Phoenix.Router.scoped_path(__MODULE__, "/static")
          def __galeria_url_prefix__, do: @galeria_url_prefix
        end
      end
    end
  end
end
