defmodule Galeria.Components.Layout do
  use BuenaVista.Component

  variant :status, [:open, :closed], :open
  classes [:sidebar_class, :main_class]

  slot :sidebar
  slot :main

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
end
