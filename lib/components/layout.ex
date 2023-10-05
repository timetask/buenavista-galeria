defmodule Galeria.Components.Layout do
  use BuenaVista.Component

  variant :status, [:open, :closed], :open

  slot :sidebar
  slot :main

  classes [:sidebar_class, :main_class]

  component sidebar_layout(assigns) do
    ~H"""
    <div class={[@base_class, @variant_classes]}>
      <sidebar class={@sidebar_class}>
        <%= render_slot(@sidebar) %>
      </sidebar>
      <main class={@main_class}>
        <%= render_slot(@main) %>
      </main>
    </div>
    """
  end

  slot :main
  slot :sidebar

  classes [:main_class, :sidebar_class]

  component inspect_layout(assigns) do
    ~H"""
    <div class={@base_class}>
      <div class={@main_class}>
        <%= render_slot(@main) %>
      </div>
      <div class={@sidebar_class}>
        <%= render_slot(@sidebar) %>
      </div>
    </div>
    """
  end

  slot :variant
  classes [:variant_class]

  component grid_layout(assigns) do
    ~H"""
    <div class={@base_class}>
      <%= for variant <- @variant do %>
        <div class={@variant_class}>
          <%= render_slot(variant) %>
        </div>
      <% end %>
    </div>
    """
  end

  variant :columns, [:one, :two, :three, :four, :five], :one
  slot :preview, required: true
  slot :editors, required: true
  slot :sidebar, required: true

  classes [
    :main_class,
    :preview_class,
    :editors_container_class,
    :sidebar_class
  ]

  component editor_layout(assigns) do
    ~H"""
    <div class={[@base_class, @variant_classes]}>
      <div class={@main_class}>
        <div class={@preview_class}>
          <%= render_slot(@preview) %>
        </div>
        <div class={@editors_container_class}>
          <%= render_slot(@editors) %>
        </div>
      </div>
      <div class={@sidebar_class}>
        <%= render_slot(@sidebar) %>
      </div>
    </div>
    """
  end
end
