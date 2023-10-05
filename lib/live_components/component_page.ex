defmodule Galeria.LiveComponents.ComponentPage do
  use Phoenix.LiveComponent

  alias BuenaVista.Component

  alias Galeria.Components.Box
  alias Galeria.Components.Input
  alias Galeria.Components.Layout
  alias Galeria.Components.Nav
  alias Galeria.Components.Table
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
      <Layout.editor_layout :if={@current_nav_id == "editor"} columns={hydrator_cols(@hydrators)}>
        <:preview>
          <Box.box>
            Preview
          </Box.box>
        </:preview>
        <:editors>
          <%= for hydrator <- @hydrators do %>
            <Typography.page_subtitle>
              <:subtitle><%= pretty_module(hydrator) %></:subtitle>
            </Typography.page_subtitle>
          <% end %>
          <%= for variant <- @current_component.variants do %>
            <%= for {option, class} when not is_nil(class) <- variant.options do %>
              <%= for hydrator <- @hydrators do %>
                <Box.box padding={:none}>
                  <Input.label>
                    :<%= variant.name %> :<%= option %>
                  </Input.label>
                  <.editor
                    id={editor_id(hydrator, @current_component, variant, option)}
                    value={editor_code(hydrator, @current_component, variant, option)}
                  />
                </Box.box>
              <% end %>
            <% end %>
          <% end %>
        </:editors>
        <:sidebar>
          <Box.box>
            <Input.group direction={:horizontal}>
              <Input.label for="theme-picker">Theme</Input.label>
              <Input.select id="theme-picker" options={theme_options(@themes)} />
            </Input.group>
          </Box.box>
          <Box.box>
            <Input.fieldset>
              <Input.group :for={variant <- @current_component.variants} direction={:horizontal}>
                <Input.label for={variant_id(@current_component, variant)}>
                  <%= variant.name %>
                </Input.label>
                <Input.select
                  id={variant_id(@current_component, variant)}
                  options={variant_options(variant)}
                />
              </Input.group>
            </Input.fieldset>
          </Box.box>
          <Box.box padding={:none}>
            <Table.table rows={@variables}>
              <:col :let={variable} label="Variable">:<%= variable.key %></:col>
              <:col :let={variable} label="Value"><%= variable.css_value %></:col>
              <:col :let={variable} label="Function">
                <%= if variable.property.type == :var do %>
                  <%= variable.property.raw_body %>
                <% else %>
                <% end %>
              </:col>
            </Table.table>
          </Box.box>
        </:sidebar>
      </Layout.editor_layout>
    </div>
    """
  end

  attr :id, :string, required: true
  attr :value, :string, required: true

  defp editor(assigns) do
    ~H"""
    <LiveMonacoEditor.code_editor
      id={@id}
      path={"#{@id}.sass"}
      value={@value}
      opts={
        Map.merge(
          LiveMonacoEditor.default_opts(),
          %{
            "fontFamily" => "Inconsolata",
            "fontSize" => "16",
            "language" => "css",
            "glyphMargin" => false,
            "folding" => false,
            "showFoldingControls" => "never",
            "lineNumbers" => "off",
            "lineDecorationsWidth" => 0,
            "lineNumbersMinChars" => 0
          }
        )
      }
    />
    """
  end

  # ----------------------------------------
  # Life Cycle
  # ----------------------------------------
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_current_nav()
     |> assign_variables()
     |> assign_hydrators()}
  end

  defp assign_variables(socket) do
    hydrator = socket.assigns.current_theme.hydrator.module_name
    variables = hydrator.get_variables() |> Enum.map(fn {_key, var} -> var end) |> Enum.reverse()
    assign(socket, :variables, variables)
  end

  defp assign_current_nav(socket) do
    nav_id =
      case Map.get(socket.assigns.params, "nav") do
        id when id in ["inspect", "grid", "editor"] -> id
        _ -> "inspect"
      end

    assign(socket, :current_nav_id, nav_id)
  end

  defp assign_hydrators(socket) do
    hydrator = socket.assigns.current_theme.hydrator
    hydrators = get_hydrators(hydrator.module_name)
    dbg(hydrators)
    assign(socket, :hydrators, hydrators)
  end

  # ----------------------------------------
  # Content
  # ----------------------------------------
  defp nav_items() do
    [
      %Nav.Item{id: "inspect", url: "?nav=inspect", text: "Inspect"},
      %Nav.Item{id: "grid", url: "?nav=grid", text: "Grid"},
      %Nav.Item{id: "editor", url: "?nav=editor", text: "Editor"}
    ]
  end

  defp find_nav_item(nav_id) when is_binary(nav_id) do
    Enum.find(nav_items(), &(&1.id == nav_id))
  end

  defp theme_options(themes) do
    for theme <- themes do
      {theme.name, theme.name}
    end
  end

  defp variant_id(%Component{} = component, %Component.Variant{} = variant) do
    "#{component.name}-variant-#{variant.name}"
  end

  defp variant_options(%Component.Variant{} = variant) do
    for {key, _value} <- variant.options do
      name = if key == variant.default, do: ":#{key} (default)", else: ":#{key}"
      {key, name}
    end
  end

  defp editor_id(hydrator, component, variant, option) do
    "#{hydrator}-#{component.name}-#{variant.name}#{option}"
  end

  defp editor_code(hydrator, component, variant, option) do
    styles = hydrator.get_styles_map()

    case Map.get(styles, {component.name, variant.name, option}) do
      %BuenaVista.Hydrator.Style{parent: false} = style -> style.css
      _ -> ""
    end
  end

  def get_hydrators(hydrator_module, acc \\ [])
  def get_hydrators(BuenaVista.Template.EmptyHydrator, acc), do: acc
  def get_hydrators(nil, acc), do: acc

  def get_hydrators(hydrator_module, acc) do
    parent = hydrator_module.get_parent()
    [hydrator_module | get_hydrators(parent, acc)]
  end

  defp hydrator_cols(hydrators) do
    case length(hydrators) do
      1 -> :one
      2 -> :two
      3 -> :three
      4 -> :four
      5 -> :five
    end
  end

  # ----------------------------------------
  # Helpers 
  # ----------------------------------------
  defp pretty_module(mod) when is_atom(mod) do
    mod |> Atom.to_string() |> String.replace("Elixir.", "")
  end

  defp pretty_component_module(%Component{} = component) do
    component.module |> pretty_module() |> then(&(&1 <> "."))
  end
end
