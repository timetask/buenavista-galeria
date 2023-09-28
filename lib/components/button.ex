defmodule Galeria.Components.Button do
  use BuenaVista.Component

  variant :size, [:sm, :md, :lg], :md
  variant :color, [:ctrl, :primary, :success, :danger], :ctrl
  variant :background, [:solid, :soft, :link, :transparent], :solid
  variant :border, [:none, :thin, :thick], :none

  attr :type, :string, default: "button", values: ["button", "submit"]
  attr :rest, :global

  slot :inner_block

  component button(assigns) do
    ~H"""
    <button class={[@base_class, @variant_classes]} type={@type} {@rest}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end
