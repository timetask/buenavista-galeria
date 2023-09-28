defmodule Galeria.GaleriaLive do
  use Phoenix.LiveView,
    layout: {Galeria.HTML.Layout, :base}

  alias BuenaVista.Component
  alias BuenaVista.Helpers
  # alias BuenaVista.Theme
  import Galeria.Components.Layout
  import Galeria.Components.Typography
  import Galeria.Components.Button

  @base_url Application.compile_env(:galeria, :base_url)
  @apps Application.compile_env(:buenavista, :apps)

  @impl true
  def mount(_params, _session, socket) do
    modules = Helpers.find_component_modules(@apps)

    {:ok,
     socket
     |> assign(:page_title, "Component System")
     |> assign(:modules, modules)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    {:noreply, handle_action(socket.assigns.live_action, params, socket)}
  end

  def handle_action(:index, _params, socket) do
    assign(socket, :current_component, nil)
  end

  def handle_action(:component, %{"component" => component}, socket) do
    component_name = String.to_existing_atom(component)

    component_search =
      for {_module, components} <- socket.assigns.modules, reduce: nil do
        acc -> find_component(components, component_name, acc)
      end

    case component_search do
      %Component{} = component -> assign(socket, :current_component, component)
      _ -> push_patch(socket, to: index_url())
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.sidebar_layout>
      <:sidebar>
        <.sidebar_title>
          Galeria
          <:actions>
            <.button size={:md} border={:thin} background={:transparent} color={:ctrl}>
              light / dark
            </.button>
            <.button size={:md} border={:thin} background={:transparent} color={:ctrl}>
              Collapse
            </.button>
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
  # helpers
  # ----------------------------------------
  # defp nav_item_state(%Component{name: :name}, %Component{name: :name}), do: :selected
  # defp nav_item_state(_component_1, _component_2), do: :default

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
  # urls
  # ----------------------------------------
  def index_url() do
    @base_url
  end

  def component_url(%Component{} = component) do
    Path.join(@base_url, Atom.to_string(component.name))
  end
end
