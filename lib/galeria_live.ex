defmodule Galeria.GaleriaLive do
  use Phoenix.LiveView,
    layout: {Galeria.HTML.Layout, :base}

  alias BuenaVista.Component
  alias BuenaVista.Helpers

  import Galeria.Components.Box
  import Galeria.Components.Button
  import Galeria.Components.Layout
  import Galeria.Components.Nav
  import Galeria.Components.Typography

  @apps Application.compile_env(:buenavista, :apps)

  @impl true
  def render(assigns) do
    ~H"""
    <.sidebar_layout status={if @sidebar_open?, do: :open, else: :closed}>
      <:sidebar>
        <.sidebar_title>
          <:title>Galeria</:title>
          <:subtitle>Component</:subtitle>
          <:actions>
            <a :if={@theme_name == "light"} href={change_theme_url(@socket, "dark")}>
              <.button size={:md} style={:transparent} color={:ctrl} icon={:light_mode} />
            </a>
            <a :if={@theme_name == "dark"} href={change_theme_url(@socket, "light")}>
              <.button size={:md} style={:transparent} color={:ctrl} icon={:dark_mode} />
            </a>
            <.button size={:md} style={:transparent} color={:ctrl} icon={:collapse} />
          </:actions>
        </.sidebar_title>
        <.collapsible_box>
          <:header>
            <.sidebar_subtitle>
              <:subtitle>Compositions</:subtitle>
              <:actions>
                <.button size={:sm} style={:transparent} color={:ctrl} icon={:chevron_down} />
              </:actions>
            </.sidebar_subtitle>
          </:header>
          <:content>
            Content
          </:content>
        </.collapsible_box>
        <.collapsible_box :for={{module, components} <- @modules}>
          <:header>
            <.sidebar_subtitle>
              <:subtitle><%= pretty_module(module) %></:subtitle>
              <:actions>
                <.button size={:sm} style={:transparent} color={:ctrl} icon={:chevron_down} />
              </:actions>
            </.sidebar_subtitle>
          </:header>
          <:content>
            <.nav_list
              direction={:vertical}
              selected_item={component_to_nav_item(@socket, @current_component)}
              items={components_to_nav_items(@socket, components)}
            />
          </:content>
        </.collapsible_box>
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
  def handle_params(_params, _uri, %{assigns: %{live_action: :index}} = socket) do
    {:noreply,
     socket
     |> assign(:current_component, nil)
     |> assign(:page_title, "Index")}
  end

  def handle_params(params, _uri, %{assigns: %{live_action: :component}} = socket) do
    case get_current_component(socket, params) do
      %Component{} = component ->
        {:noreply,
         socket
         |> assign(:current_component, component)
         |> assign(:page_title, component.name)}

      _ ->
        {:noreply, push_patch(socket, to: base_url(socket))}
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
  defp get_current_component(%Phoenix.LiveView.Socket{} = socket, params) when is_map(params) do
    component_name = params |> Map.get("component_name") |> String.to_existing_atom()

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

  defp components_to_nav_items(socket, components) do
    for {_, component} <- components, do: component_to_nav_item(socket, component)
  end

  defp component_to_nav_item(socket, component) do
    %Galeria.Components.Nav.Item{
      id: component.name,
      url: component_url(socket, component),
      text: component.name
    }
  end

  defp pretty_module(mod) do
    mod |> Module.split() |> List.last()
  end

  # ----------------------------------------
  # Urls
  # ----------------------------------------
  def base_url(socket) do
    socket.router.__galeria_url_prefix__()
  end

  def component_url(socket, %Component{} = component) do
    Path.join(base_url(socket), "/component/" <> Atom.to_string(component.name))
  end

  def change_theme_url(socket, theme_name) when is_binary(theme_name) do
    Path.join(base_url(socket), "/change-theme/#{theme_name}")
  end
end
