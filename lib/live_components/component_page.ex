defmodule Galeria.LiveComponents.ComponentPage do
  use Phoenix.LiveComponent

  alias BuenaVista.Component

  alias Galeria.Components.Box
  alias Galeria.Components.Layout
  alias Galeria.Components.Nav
  alias Galeria.Components.Typography

  def render(assigns) do
    ~H"""
    <div>
      <Typography.page_title>
        <:title><%= @current_component.name %></:title>
        <:subtitle><%= pretty_component_module(@current_component) %></:subtitle>
        <:actions>
          <Nav.nav_list
            direction={:horizontal}
            selected_item={find_nav_item(@current_nav_id)}
            items={nav_items()}
          />
        </:actions>
      </Typography.page_title>
      <Layout.inspect_layout :if={@current_nav_id == "inspect"}>
        <:main>Main</:main>
        <:sidebar>Sidebar</:sidebar>
      </Layout.inspect_layout>
      <Layout.grid_layout :if={@current_nav_id == "grid"}>
        <:variant>Variant 1</:variant>
        <:variant>Variant 2</:variant>
      </Layout.grid_layout>
      <Layout.editor_layout :if={@current_nav_id == "editor"}>
        <:preview>
          <Box.box>
            Preview 
          </Box.box>
        </:preview>
        <:hydrator>
          <Box.box>
            Hydrator
          </Box.box>
        </:hydrator>
        <:hydrator>
          <Box.box>
            Parent Hydrator
          </Box.box>
        </:hydrator>
        <:sidebar>
          <Box.box>
            Theme Picker
          </Box.box>
          <Box.box>
            Variant picker
          </Box.box>
          <Box.box padding={:none}>
            Variables
          </Box.box>
        </:sidebar>
      </Layout.editor_layout>
    </div>
    """
  end

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_current_nav()}
  end

  defp assign_current_nav(socket) do
    nav_id =
      case Map.get(socket.assigns.params, "nav") do
        id when id in ["inspect", "grid", "editor"] -> id
        _ -> "inspect"
      end

    assign(socket, :current_nav_id, nav_id)
  end

  defp pretty_component_module(%Component{} = component) do
    component.module |> Atom.to_string() |> String.replace("Elixir.", "") |> then(&(&1 <> "."))
  end

  defp find_nav_item(nav_id) when is_binary(nav_id) do
    Enum.find(nav_items(), &(&1.id == nav_id))
  end

  defp nav_items() do
    [
      %Nav.Item{id: "inspect", url: "?nav=inspect", text: "Inspect"},
      %Nav.Item{id: "grid", url: "?nav=grid", text: "Grid"},
      %Nav.Item{id: "editor", url: "?nav=editor", text: "Editor"}
    ]
  end
end
