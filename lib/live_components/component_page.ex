defmodule Galeria.LiveComponents.ComponentPage do
  use Phoenix.LiveComponent
  require Phoenix.LiveView.TagEngine

  alias BuenaVista.Component
  alias BuenaVista.Theme

  alias Galeria.Components.Box
  alias Galeria.Components.Input
  alias Galeria.Components.Layout
  alias Galeria.Components.Nav
  alias Galeria.Components.Table
  alias Galeria.Components.Typography

  @attr_changed_event "attr-changed-"
  @variant_changed_event "variant-changed-"

  @impl true
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
              theme_app={@current_theme_app}
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
                  <Input.label for={
                    editor_id(
                      @current_project_theme.name,
                      hydrator,
                      @current_component,
                      variant,
                      option
                    )
                  }>
                    <%= variant.name %>: <%= option %>
                  </Input.label>
                  <Input.codearea
                    id={
                      editor_id(
                        @current_project_theme.name,
                        hydrator,
                        @current_component,
                        variant,
                        option
                      )
                    }
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
            <.form
              :let={form}
              for={%{"theme" => @current_project_theme.name}}
              phx-change="theme-change"
            >
              <Input.group direction={:horizontal}>
                <Input.label for="theme-picker">Theme</Input.label>
                <Input.select
                  field={form[:theme]}
                  options={for(theme <- @themes, do: {theme.name, theme.name})}
                />
              </Input.group>
            </.form>
          </Box.box>
          <Typography.page_subtitle subtitle="Variants" />
          <.component_variants
            component={@current_component}
            target={@myself}
            selected_variants={@selected_variants}
          />
          <Typography.page_subtitle subtitle="Attrs" />
          <.component_attributes
            component={@current_component}
            target={@myself}
            selected_attrs={@selected_attrs}
          />
          <Typography.page_subtitle subtitle="Slots" />
          <.component_slots theme_name={@current_project_theme.name} component={@current_component} />
          <Typography.page_subtitle subtitle="Variables" />
          <.component_variables variables={@variables} />
        </:sidebar>
      </Layout.editor_layout>
    </div>
    """
  end

  attr :component, Component, required: true
  attr :theme_app, BuenaVista.Theme.App, required: true
  attr :args, :any, required: true

  defp component_preview(assigns) do
    ~H"""
    <div id="galeria-preview">
      <style>
        <%= preview_css(@theme_app, @component, "#galeria-preview") %>
      </style>
      <%= Phoenix.LiveView.TagEngine.component(
        Function.capture(@component.module, @component.name, 1),
        @args,
        {__ENV__.module, __ENV__.function, __ENV__.file, __ENV__.line}
      ) %>
    </div>
    """
  end

  attr :component, Component, required: true
  attr :selected_variants, :map, required: true
  attr :target, :any

  defp component_variants(assigns) do
    ~H"""
    <Box.box>
      <Input.fieldset>
        <.form
          :let={form}
          :for={variant <- @component.variants}
          for={%{variant_field_name(variant.name) => Map.get(@selected_variants, variant.name)}}
          phx-change={variant_changed_event(variant.name)}
          phx-target={@target}
        >
          <Input.group direction={:horizontal}>
            <Input.label field={form[variant_field_name(variant.name) |> String.to_atom()]}>
              <%= variant.name %>
            </Input.label>
            <Input.select
              field={form[variant_field_name(variant.name) |> String.to_atom()]}
              options={variant_options(variant)}
            />
          </Input.group>
        </.form>
      </Input.fieldset>
    </Box.box>
    """
  end

  attr :component, Component, required: true
  attr :selected_attrs, :map, required: true
  attr :target, :any

  defp component_attributes(assigns) do
    ~H"""
    <Box.box>
      <Input.fieldset>
        <.form
          :let={form}
          :for={attr <- @component.attrs}
          phx-change={attr_changed_event(attr.name)}
          for={%{attr_field_name(attr.name) => Map.get(@selected_attrs, attr.name)}}
          phx-target={@target}
        >
          <Input.group direction={:horizontal}>
            <Input.label field={form[attr_field_name(attr.name) |> String.to_atom()]}>
              <%= attr.name %>
            </Input.label>
            <.attr_input
              field={form[attr_field_name(attr.name) |> String.to_atom()]}
              attr={attr}
            />
          </Input.group>
        </.form>
      </Input.fieldset>
    </Box.box>
    """
  end

  attr :attr, :map, required: true
  attr :field, Phoenix.HTML.FormField

  defp attr_input(assigns) do
    with opts when is_list(opts) <- Map.get(assigns.attr, :opts),
         values when is_list(values) <- Keyword.get(opts, :values),
         options = for(v <- values, do: {v, v}) do
      assigns = assign(assigns, :options, options)

      ~H[<Input.select field={@field} options={@options} />]
    else
      _ ->
        ~H[<Input.input id={@field.id} />]
    end
  end

  attr :theme_name, :string, required: true
  attr :component, Component, required: true

  defp component_slots(assigns) do
    ~H"""
    <Box.box>
      <Input.fieldset>
        <Input.group :for={slot <- @component.slots} direction={:horizontal}>
          <Input.label for={slot_id(@theme_name, @component, slot)}>
            <%= slot.name %>
          </Input.label>
          <Input.codearea id={slot_id(@theme_name, @component, slot)} />
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

  # ----------------------------------------
  # Life Cycle
  # ----------------------------------------
  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_current_nav()
     |> assign_current_theme_app()
     |> assign_selected_attrs()
     |> assign_selected_variants()
     |> assign_preview_args()
     |> assign_variables()
     |> assign_hydrators()}
  end

  # ----------------------------------------
  # Assigns
  # ----------------------------------------
  defp assign_current_nav(socket) do
    nav_id =
      case Map.get(socket.assigns.params, "nav") do
        id when id in ["inspect", "grid", "editor"] -> id
        _ -> "inspect"
      end

    assign(socket, :current_nav_id, nav_id)
  end

  defp assign_selected_attrs(socket) do
    selected_attrs =
      for attr <- socket.assigns.current_component.attrs, into: %{} do
        opts = Map.get(attr, :opts, [])
        default = Keyword.get(opts, :default, :__not_found__)
        values = Keyword.get(opts, :values, :__not_found__)

        value =
          case {default, values} do
            {:__not_found__, :__not_found__} -> nil
            {:__not_found__, values} -> List.first(values)
            {default, _values} -> default
          end

        {attr.name, value}
      end

    assign(socket, :selected_attrs, selected_attrs)
  end

  defp assign_selected_variants(socket) do
    selected_variants =
      for variant <- socket.assigns.current_component.variants, into: %{} do
        {variant.name, variant.default}
      end

    assign(socket, :selected_variants, selected_variants)
  end

  defp assign_preview_args(socket) do
    # TODO: assign slots
    assigns = []
    inner_block = Phoenix.LiveView.TagEngine.inner_block(:inner_block, do: ~H[Hello!])
    args = %{inner_block: %{slot: :inner_block, inner_block: inner_block}}
    assign(socket, :preview_args, args)
  end

  defp assign_current_theme_app(socket) do
    %Theme.App{} =
      app =
      Enum.find(socket.assigns.current_project_theme.apps, fn %Theme.App{} = app ->
        app.name == socket.assigns.current_component.app
      end)

    assign(socket, :current_theme_app, app)
  end

  defp assign_variables(socket) do
    variables =
      socket.assigns.current_theme_app.hydrator.module.get_variables()
      |> Enum.map(fn {_key, var} -> var end)
      |> Enum.reverse()

    assign(socket, :variables, variables)
  end

  defp assign_hydrators(socket) do
    %Theme.Hydrator{} = hydrator = socket.assigns.current_theme_app.hydrator
    hydrators = get_hydrators(hydrator.module)
    assign(socket, :hydrators, hydrators)
  end

  # ----------------------------------------
  # Events 
  # ----------------------------------------
  @impl true
  def handle_event(@attr_changed_event <> attr_name, params, socket) do
    attr_name = String.to_existing_atom(attr_name)

    attr =
      Enum.find(
        socket.assigns.current_component.attrs,
        fn attr -> attr.name == attr_name end
      )

    attr_value =
      params
      |> Map.get(attr_field_name(attr_name))
      |> then(fn attr_value ->
        case attr.type do
          :atom -> String.to_existing_atom(attr_value)
          :string -> attr_value
        end
      end)

    selected_attrs = Map.put(socket.assigns.selected_attrs, attr_name, attr_value)

    {:noreply, assign(socket, :selected_attrs, selected_attrs)}
  end

  def handle_event(@variant_changed_event <> variant_name, params, socket) do
    value =
      params
      |> Map.get(variant_field_name(variant_name))
      |> String.to_existing_atom()

    variant_name = String.to_existing_atom(variant_name)
    selected_variants = Map.put(socket.assigns.selected_variants, variant_name, value)

    {:noreply, assign(socket, :selected_variants, selected_variants)}
  end

  # Events
  defp attr_changed_event(attr_name), do: "#{@attr_changed_event}#{attr_name}"
  defp variant_changed_event(variant_name), do: "#{@variant_changed_event}#{variant_name}"

  # Fields
  defp attr_field_name(attr_name), do: "#{attr_name}"
  defp variant_field_name(variant_name), do: "variant-#{variant_name}"

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

  defp variant_options(%Component.Variant{} = variant) do
    for {key, _value} <- variant.options do
      name = if key == variant.default, do: ":#{key} (default)", else: ":#{key}"
      {key, name}
    end
  end

  defp slot_id(theme_name, component, slot) do
    "#{theme_name}-#{component.name}-#{slot.name}-#{slot.line}"
  end

  defp editor_id(theme_name, hydrator, component, variant, option) do
    "#{theme_name}-#{hydrator}-#{component.name}-#{variant.name}-#{option}"
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
  def get_hydrators(BuenaVista.Themes.EmptyHydrator, acc), do: acc
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

  defp preview_css(theme_app, component, prefix) do
    BuenaVista.Generator.generate_app_components_raw_css(
      theme_app,
      [{component.name, component}],
      prefix
    )
    |> Phoenix.HTML.raw()
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
