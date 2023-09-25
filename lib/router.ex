defmodule Galeria.Router do
  defmacro galeria(path, opts \\ []) do
    quote bind_quoted: binding() do
      scope path, alias: false, as: false do
        import Phoenix.Router, only: [get: 4]
        import Phoenix.LiveView.Router, only: [live: 3, live_session: 3]

        live_session :galeria, root_layout: {Galeria.HTML.Layout, :root} do
          # LiveDashboard assets
          get "/css-:md5", Galeria.Assets, :css, as: :galeria_asset
          get "/js-:md5", Galeria.Assets, :js, as: :galeria_asset

          # All helpers are public contracts and cannot be changed
          live "/", Galeria.Live, :index
          live "/ensambles/:ensamble_name", Galeria.Live, :ensamble
          live "/component/:component_name", Galeria.Live, :component
        end
      end
    end
  end
end
