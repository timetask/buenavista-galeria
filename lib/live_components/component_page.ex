defmodule Galeria.LiveComponents.ComponentPage do
  use Phoenix.LiveComponent
  require Phoenix.LiveView.TagEngine

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
          <Typography.page_subtitle subtitle="Preview" />
          <Box.box>
            <.component_preview
              component={@current_component}
              theme={@current_theme}
              args={@preview_args}
            />
          </Box.box>
        </:preview>
        <:editors>
          <%= for hydrator <- @hydrators do %>
            <Typography.page_subtitle subtitle={pretty_module(hydrator)} />
          <% end %>
          <%= for variant <- @current_component.variants do %>
            <%= for {option, class} when not is_nil(class) <- variant.options do %>
              <%= for hydrator <- @hydrators do %>
                <Box.box padding={:none}>
                  <Input.label>
                    <%= variant.name %>: <%= option %>
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
          <Typography.page_subtitle subtitle="Theme" />
          <Box.box>
            <Input.group direction={:horizontal}>
              <Input.label for="theme-picker">Theme</Input.label>
              <Input.select id="theme-picker" options={theme_options(@themes)} />
            </Input.group>
          </Box.box>
          <Typography.page_subtitle subtitle="Variants" />
          <.component_variants component={@current_component} />
          <Typography.page_subtitle subtitle="Attrs" />
          <.component_attributes component={@current_component} />
          <Typography.page_subtitle subtitle="Slots" />
          <.component_slots component={@current_component} />
          <Typography.page_subtitle subtitle="Variables" />
          <.component_variables variables={@variables} />
        </:sidebar>
      </Layout.editor_layout>
    </div>
    """
  end

  attr :component, Component, required: true
  attr :theme, BuenaVista.Theme, required: true
  attr :args, :any, required: true

  defp component_preview(assigns) do
    ~H"""
    <div>
      <%= Phoenix.LiveView.TagEngine.component(
        Function.capture(@component.module, @component.name, 1),
        @args,
        {__ENV__.module, __ENV__.function, __ENV__.file, __ENV__.line}
      ) %>
    </div>
    """
  end

  attr :component, Component, required: true

  defp component_variants(assigns) do
    ~H"""
    <Box.box>
      <Input.fieldset>
        <Input.group :for={variant <- @component.variants} direction={:horizontal}>
          <Input.label for={variant_id(@component, variant)}>
            <%= variant.name %>
          </Input.label>
          <Input.select id={variant_id(@component, variant)} options={variant_options(variant)} />
        </Input.group>
      </Input.fieldset>
    </Box.box>
    """
  end

  attr :component, Component, required: true

  defp component_attributes(assigns) do
    ~H"""
    <Box.box>
      <Input.fieldset>
        <Input.group :for={attr <- @component.attrs} direction={:horizontal}>
          <Input.label for={attr_id(@component, attr)}>
            <%= attr.name %>
          </Input.label>
          <% dbg(attr) %>
          <Input.input />
        </Input.group>
      </Input.fieldset>
    </Box.box>
    """
  end

  attr :component, Component, required: true

  defp component_slots(assigns) do
    ~H"""
    <Box.box>
      <Input.fieldset>
        <Input.group :for={slot <- @component.slots} direction={:horizontal}>
          <Input.label for={slot_id(@component, slot)}>
            <%= slot.name %>
          </Input.label>
          <Input.input />
        </Input.group>
      </Input.fieldset>
    </Box.box>
    """
  end

  attr :variables, :list, required: true

  defp component_variables(assigns) do
    ~H"""
    <Box.box padding={:none}>
      <Table.table rows={@variables}>
        <:col :let={variable} label="Key">:<%= variable.key %></:col>
        <:col :let={variable} label="Value"><%= variable.css_value %></:col>
        <:col :let={variable} label="Function">
          <%= if variable.property.type == :var do %>
            <%= variable.property.raw_body %>
          <% else %>
          <% end %>
        </:col>
      </Table.table>
    </Box.box>
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
            "language" => nil,
            "wordWrap" => "on",
            "glyphMargin" => false,
            "folding" => false,
            "showFoldingControls" => "never",
            "lineNumbers" => "off",
            "lineDecorationsWidth" => 0,
            "lineNumbersMinChars" => 0,
            "theme" => "vs-dark"
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
     |> assign_preview_args()
     |> assign_variables()
     |> assign_hydrators()}
  end

  defp assign_preview_args(socket) do
    assigns = []
    inner_block = Phoenix.LiveView.TagEngine.inner_block(:inner_block, do: ~H[Hello!])
    args = %{inner_block: %{slot: :inner_block, inner_block: inner_block}}
    assign(socket, :preview_args, args)
  end

  defp assign_variables(socket) do
    hydrator = socket.assigns.current_theme.hydrator.module_name

    variables =
      hydrator.get_variables()
      |> Enum.map(fn {_key, var} -> var end)
      |> Enum.reverse()

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

  defp attr_id(component, attr) do
    "#{component.name}-#{attr.name}-#{attr.line}"
  end

  defp slot_id(component, attr) do
    "#{component.name}-#{attr.name}-#{attr.line}"
  end

  defp editor_id(hydrator, component, variant, option) do
    "#{hydrator}-#{component.name}-#{variant.name}-#{option}"
  end

  defp editor_code(hydrator, component, variant, option) do
    styles = hydrator.get_styles_map()

    case Map.get(styles, {component.name, variant.name, option}) do
      %BuenaVista.Hydrator.Style{parent: false} = style ->
        style.raw_css |> String.replace(~r/^  /, "") |> String.replace(~r/\n  /, "\n")

      _ ->
        ""
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
