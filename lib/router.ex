defmodule Galeria.Router do
  defmacro galeria(path, opts \\ []) do
    quote bind_quoted: binding() do
      scope path, alias: false, as: false do
        import Phoenix.Router, only: [get: 4]
        import Phoenix.LiveView.Router, only: [live: 3, live_session: 3]

        live_session :galeria, root_layout: {Galeria.HTML.Layout, :root} do
          # LiveDashboard assets
          get "/css-:md5", Galeria.AssetsController, :css, as: :galeria_asset
          get "/js-:md5", Galeria.AssetsController, :js, as: :galeria_asset

          # All helpers are public contracts and cannot be changed
          live "/", Galeria.GaleriaLive, :index
          live "/ensambles/:ensamble_name", Galeria.GaleriaLive, :ensamble
          live "/component/:component_name", Galeria.GaleriaLive, :component
        end
      end
    end
  end
end
