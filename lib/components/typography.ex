defmodule Galeria.Components.Typography do
  use BuenaVista.Component

  classes [:title_class, :actions_class]

  slot :actions

  component sidebar_title(assigns) do
    ~H"""
    <header class={@base_class}>
      <h1 class={@title_class}><%= render_slot(@inner_block) %></h1>
      <div :if={not Enum.empty?(@actions)} class={@actions_class}>
        <%= render_slot(@actions) %>
      </div>
    </header>
    """
  end
end
