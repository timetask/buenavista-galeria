defmodule Galeria.GaleriaLive do
  use Phoenix.LiveView,
    layout: {Galeria.HTML.Layout, :base}

  alias BuenaVista.Component
  alias BuenaVista.Helpers

  alias Galeria.Components.Box
  alias Galeria.Components.Button
  alias Galeria.Components.Layout
  alias Galeria.Components.Nav
  alias Galeria.Components.Typography

  @impl true
  def render(assigns) do
    ~H"""
    <Layout.sidebar_layout status={if @sidebar_open?, do: :open, else: :closed}>
      <:sidebar>
        <Typography.sidebar_title>
          <:title>Galeria</:title>
          <:subtitle>Component</:subtitle>
          <:actions>
            <a :if={@galeria_theme_name == "light"} href={change_galeria_theme_url(@base_url, "dark")}>
              <Button.button size={:md} style={:transparent} color={:ctrl} icon={:light_mode} />
            </a>
            <a :if={@galeria_theme_name == "dark"} href={change_galeria_theme_url(@base_url, "light")}>
              <Button.button size={:md} style={:transparent} color={:ctrl} icon={:dark_mode} />
            </a>
            <Button.button size={:md} style={:transparent} color={:ctrl} icon={:collapse} />
          </:actions>
        </Typography.sidebar_title>
        <Box.collapsible_box>
          <:header>
            <Typography.sidebar_subtitle>
              <:subtitle>Compositions</:subtitle>
              <:actions>
                <Button.button size={:sm} style={:transparent} color={:ctrl} icon={:chevron_down} />
              </:actions>
            </Typography.sidebar_subtitle>
          </:header>
          <:content>
            Content
          </:content>
        </Box.collapsible_box>
        <Box.collapsible_box :for={{module, components} <- @modules}>
          <:header>
            <Typography.sidebar_subtitle>
              <:subtitle><%= pretty_module_short(module) %></:subtitle>
              <:actions>
                <Button.button size={:sm} style={:transparent} color={:ctrl} icon={:chevron_down} />
              </:actions>
            </Typography.sidebar_subtitle>
          </:header>
          <:content>
            <Nav.nav_list
              direction={:vertical}
              selected_item={component_to_nav_item(@base_url, @current_component, @params)}
              items={components_to_nav_items(@base_url, components, @params)}
            />
          </:content>
        </Box.collapsible_box>
      </:sidebar>
      <:main>
        <.live_component
          :if={@live_action == :component}
          id={"component-#{@current_component.name}"}
          module={Galeria.LiveComponents.ComponentPage}
          themes={@project_themes}
          current_project_theme={@current_project_theme}
          current_component={@current_component}
          params={@params}
        />
      </:main>
    </Layout.sidebar_layout>
    """
  end

  # ----------------------------------------
  # Life Cycle
  # ----------------------------------------
  @impl true
  def mount(_params, session, socket) do
    base_url = socket.router.__galeria_url_prefix__()

    {:ok,
     socket
     |> assign(:base_url, base_url)
     |> assign_sidebar_status()
     |> assign_galeria_theme(session)
     |> assign_project_themes()
     |> assign_current_project_theme()
     |> assign_modules()}
  end

  @impl true
  def handle_params(params, _uri, %{assigns: %{live_action: :index}} = socket) do
    {:noreply,
     socket
     |> assign(:current_component, nil)
     |> assign(:params, params)
     |> assign(:page_title, "Index")}
  end

  def handle_params(params, _uri, %{assigns: %{live_action: :component}} = socket) do
    case get_current_component(socket, params) do
      %Component{} = component ->
        {:noreply,
         socket
         |> assign(:current_component, component)
         |> assign(:params, params)
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

  defp assign_galeria_theme(socket, session) do
    theme_name =
      with theme_name when is_binary(theme_name) <- Map.get(session, "galeria_theme_name"),
           {:ok, _theme} <- Galeria.GaleriaConfig.find_theme(theme_name) do
        theme_name
      else
        _ ->
          {:ok, theme} = Galeria.GaleriaConfig.get_default_theme()
          theme.name
      end

    assign(socket, :galeria_theme_name, theme_name)
  end

  defp assign_project_themes(socket) do
    themes =
      BuenaVista.Themes.get_themes()
      |> Enum.reject(fn theme -> theme.gen_css? == false end)

    assign(socket, :project_themes, themes)
  end

  defp assign_current_project_theme(socket) do
    theme = List.first(socket.assigns.project_themes)
    assign(socket, :current_project_theme, theme)
  end

  defp assign_modules(socket) do
    modules = Helpers.find_component_modules(socket.assigns.current_project_theme.apps)
    assign(socket, :modules, modules)
  end

  # ----------------------------------------
  # Events
  # ----------------------------------------
  @impl true
  def handle_event("theme-change", %{"theme" => theme_name}, socket) do
    theme = Enum.find(socket.assigns.project_themes, &(&1.name == theme_name))
    {:noreply, assign(socket, :current_project_theme, theme)}
  end

  # ----------------------------------------
  # Helpers
  # ----------------------------------------
  defp get_current_component(socket, params) when is_map(params) do
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

  defp components_to_nav_items(base_url, components, params) do
    for {_, component} <- components, do: component_to_nav_item(base_url, component, params)
  end

  defp component_to_nav_item(_base_url, nil, _params), do: nil

  defp component_to_nav_item(base_url, %Component{} = component, params) do
    component_url = component_url(base_url, component) |> URI.parse()

    final_url =
      if nav_item = Map.get(params, "nav"),
        do: component_url |> URI.append_query("nav=#{nav_item}") |> URI.to_string(),
        else: component_url |> URI.to_string()

    %Nav.Item{id: component.name, url: final_url, text: component.name}
  end

  defp pretty_module_short(mod) when is_atom(mod) do
    mod |> Module.split() |> List.last()
  end

  # ----------------------------------------
  # Urls
  # ----------------------------------------
  def base_url(base_url) do
    base_url
  end

  def component_url(base_url, %Component{} = component) do
    Path.join(base_url, "/component/" <> Atom.to_string(component.name))
  end

  def change_galeria_theme_url(base_url, theme_name) when is_binary(theme_name) do
    Path.join(base_url, "/change-theme/#{theme_name}")
  end
end
