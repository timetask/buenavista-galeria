defmodule Galeria.Components.Button do
  use BuenaVista.Component

  variant :size, [:sm, :md, :lg], :md
  variant :color, [:ctrl, :primary, :success, :danger], :ctrl
  variant :style, [:solid, :soft, :link, :transparent], :solid
  variant :border, [:none, :thin, :thick], :none

  attr :type, :string, default: "button", values: ["button", "submit"]

  attr :icon, :atom,
    values: [:light_mode, :dark_mode, :collapse, :chevron_up, :chevron_down, :expand, nil],
    default: nil

  attr :rest, :global

  slot :inner_block

  classes [:icon_class]

  component button(assigns) do
    ~H"""
    <button class={[@base_class, @variant_classes]} type={@type} {@rest}>
      <%= unless is_nil(@icon) do %>
        <.icon icon={@icon} class={@icon_class} />
      <% end %>
      <%= unless Enum.empty?(@inner_block) do %>
        <%= render_slot(@inner_block) %>
      <% end %>
    </button>
    """
  end

  defp icon(%{icon: :light_mode} = assigns) do
    ~H"""
    <svg class={@class} xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
      <path d="M6.995 12c0 2.761 2.246 5.007 5.007 5.007s5.007-2.246 5.007-5.007-2.246-5.007-5.007-5.007S6.995 9.239 6.995 12zM11 19h2v3h-2zm0-17h2v3h-2zm-9 9h3v2H2zm17 0h3v2h-3zM5.637 19.778l-1.414-1.414 2.121-2.121 1.414 1.414zM16.242 6.344l2.122-2.122 1.414 1.414-2.122 2.122zM6.344 7.759 4.223 5.637l1.415-1.414 2.12 2.122zm13.434 10.605-1.414 1.414-2.122-2.122 1.414-1.414z">
      </path>
    </svg>
    """
  end

  defp icon(%{icon: :dark_mode} = assigns) do
    ~H"""
    <svg class={@class} xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
      <path d="M12 11.807A9.002 9.002 0 0 1 10.049 2a9.942 9.942 0 0 0-5.12 2.735c-3.905 3.905-3.905 10.237 0 14.142 3.906 3.906 10.237 3.905 14.143 0a9.946 9.946 0 0 0 2.735-5.119A9.003 9.003 0 0 1 12 11.807z">
      </path>
    </svg>
    """
  end

  defp icon(%{icon: :collapse} = assigns) do
    ~H"""
    <svg class={@class} xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
      <path d="M4 6h2v12H4zm10 7h6v-2h-6V6l-6 6 6 6z"></path>
    </svg>
    """
  end

  defp icon(%{icon: :expand} = assigns) do
    ~H"""
    <svg class={@class} xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
      <path d="M18 6h2v12h-2zm-8 5H4v2h6v5l6-6-6-6z"></path>
    </svg>
    """
  end

  defp icon(%{icon: :chevron_up} = assigns) do
    ~H"""
    <svg class={@class} xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
      <path d="m12 6.879-7.061 7.06 2.122 2.122L12 11.121l4.939 4.94 2.122-2.122z"></path>
    </svg>
    """
  end

  defp icon(%{icon: :chevron_down} = assigns) do
    ~H"""
    <svg class={@class} xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
      <path d="M16.939 7.939 12 12.879l-4.939-4.94-2.122 2.122L12 17.121l7.061-7.06z"></path>
    </svg>
    """
  end
end
