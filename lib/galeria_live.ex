defmodule Galeria.GaleriaLive do
  use Phoenix.LiveView,
    layout: {Galeria.HTML.Layout, :base}

  alias BuenaVista.Component
  alias BuenaVista.Helpers
  import Galeria.Components.Layout
  import Galeria.Components.Typography
  import Galeria.Components.Button

  @base_url Application.compile_env(:galeria, :base_url)
  @apps Application.compile_env(:buenavista, :apps)

  @impl true
  def render(assigns) do
    ~H"""
    <.sidebar_layout status={if @sidebar_open?, do: :open, else: :closed}>
      <:sidebar>
        <.sidebar_title>
          Galeria
          <:actions>
            <a :if={@theme_name == "light"} href={change_theme_url(@socket, "dark")}>
              <.button
                size={:md}
                border={:thin}
                style={:transparent}
                color={:ctrl}
                icon={:light_mode}
              />
            </a>
            <a :if={@theme_name == "dark"} href={change_theme_url(@socket, "light")}>
              <.button size={:md} border={:thin} style={:transparent} color={:ctrl} icon={:dark_mode} />
            </a>
            <.button
              :if={@sidebar_open?}
              size={:md}
              border={:thin}
              style={:transparent}
              color={:ctrl}
              icon={:collapse}
            />
            <.button
              :if={not @sidebar_open?}
              size={:md}
              border={:thin}
              style={:transparent}
              color={:ctrl}
              icon={:collapse}
            />
          </:actions>
        </.sidebar_title>
      </:sidebar>
      <:main>
        <%= @live_action %>
        <%= inspect(@current_component) %>
      </:main>
    </.sidebar_layout>
    """
  end

  # ----------------------------------------
  # Life Cycle
  # ----------------------------------------
  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign_sidebar_status()
     |> assign_theme(session)
     |> assign_modules()}
  end

  @impl true
  def handle_params(params, _uri, %{assigns: %{live_action: :index}} = socket) do
    {:noreply,
     socket
     |> assign(:current_component, nil)
     |> assign(:page_title, "Index")}
  end

  def handle_params(params, _uri, %{assigns: %{live_action: :component}} = socket) do
    dbg("handle params live_action: :component")

    component = get_current_component(socket, params)

    if match?(%Component{}, component) do
      socket
      |> assign(:current_component, component)
      |> assign(:page_title, "#{component.name} #{component.__MODULE__}")
    else
      push_patch(socket, to: index_url())
    end
  end

  # ----------------------------------------
  # Assigns
  # ----------------------------------------
  defp assign_sidebar_status(socket) do
    assign(socket, :sidebar_open?, true)
  end

  defp assign_modules(socket) do
    modules = Helpers.find_component_modules(@apps)
    assign(socket, :modules, modules)
  end

  defp assign_theme(socket, session) do
    theme_name =
      with theme_name when is_binary(theme_name) <- Map.get(session, "galeria_theme_name"),
           {:ok, _theme} <- Galeria.Config.find_theme(theme_name) do
        theme_name
      else
        _ ->
          {:ok, theme} = Galeria.Config.get_default_theme()
          theme.name
      end

    assign(socket, :theme_name, theme_name)
  end

  # ----------------------------------------
  # Events
  # ----------------------------------------

  # ----------------------------------------
  # Helpers
  # ----------------------------------------
  # defp nav_item_state(%Component{name: :name}, %Component{name: :name}), do: :selected
  # defp nav_item_state(_component_1, _component_2), do: :default

  defp get_current_component(%Phoenix.LiveView.Socket{} = socket, params) when is_map(params) do
    component_name = params |> Map.get("component") |> String.to_existing_atom()

    for {_module, components} <- socket.assigns.modules, reduce: nil do
      acc -> find_component(components, component_name, acc)
    end
  end

  defp find_component(_components, _component_name, %Component{} = component), do: component

  defp find_component(components, component_name, _acc) do
    result = Enum.find(components, fn {name, _comp} -> name == component_name end)

    case result do
      {_, component} -> component
      _ -> nil
    end
  end

  # defp build_component_items(components) do
  #   for {_, component} <- components do
  #     %{url: component_url(component), nav: :patch, item: component}
  #   end
  # end

  # ----------------------------------------
  # Urls
  # ----------------------------------------
  def index_url() do
    @base_url
  end

  def component_url(%Component{} = component) do
    Path.join(@base_url, Atom.to_string(component.name))
  end

  def change_theme_url(socket, theme_name) when is_binary(theme_name) do
    prefix = socket.private.connect_info.private.phoenix_router.__galeria_url_prefix__()
    Path.join(prefix, "/change-theme/#{theme_name}")
  end
end
