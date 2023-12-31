defmodule Galeria.Components.Box do
  use BuenaVista.Component

  variant :status, [:open, :closed], :open
  classes [:header_class, :content_class]

  slot :header, required: true
  slot :content, required: true

  component collapsible_box(assigns) do
    ~H"""
    <div class={[@base_class, @variant_classes]}>
      <div class={@header_class}>
        <%= render_slot(@header) %>
      </div>
      <div class={@content_class}>
        <%= render_slot(@content) %>
      </div>
    </div>
    """
  end

  variant :padding, [:sm, :md, :lg, :none], :md
  slot :inner_block

  component box(assigns) do
    ~H"""
    <div class={[@base_class, @variant_classes]}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
