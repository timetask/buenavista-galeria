defmodule Galeria.Components.Typography do
  use BuenaVista.Component

  classes [:title_class, :subtitle_class, :actions_class]

  slot :title, required: true
  slot :subtitle
  slot :actions

  component sidebar_title(assigns) do
    ~H"""
    <header class={@base_class}>
      <div class={@title_class}>
        <span :if={not Enum.empty?(@subtitle)} class={@subtitle_class}>
          <%= render_slot(@subtitle) %>
        </span>
        <%= render_slot(@title) %>
      </div>
      <div :if={not Enum.empty?(@actions)} class={@actions_class}>
        <%= render_slot(@actions) %>
      </div>
    </header>
    """
  end

  classes [:subtitle_class, :actions_class]

  slot :subtitle, required: true
  slot :actions

  component sidebar_subtitle(assigns) do
    ~H"""
    <header class={@base_class}>
      <h3 class={@subtitle_class}>
        <%= render_slot(@subtitle) %>
      </h3>
      <div :if={not Enum.empty?(@actions)} class={@actions_class}>
        <%= render_slot(@actions) %>
      </div>
    </header>
    """
  end

  classes [:title_class, :subtitle_class, :actions_class]

  slot :title, required: true
  slot :actions
  slot :subtitle

  component page_title(assigns) do
    ~H"""
    <header class={@base_class}>
      <h1 class={@title_class}>
        <span :if={not Enum.empty?(@subtitle)} class={@subtitle_class}>
          <%= render_slot(@subtitle) %>
        </span>
        <%= render_slot(@title) %>
      </h1>
      <div :if={not Enum.empty?(@actions)} class={@actions_class}>
        <%= render_slot(@actions) %>
      </div>
    </header>
    """
  end

  attr :subtitle, :string, required: true
  slot :actions

  classes [:subtitle_class, :actions_class]

  component page_subtitle(assigns) do
    ~H"""
    <header class={@base_class}>
      <h2 class={@subtitle_class}>
        <%= @subtitle %>
      </h2>
      <div :if={not Enum.empty?(@actions)} class={@actions_class}>
        <%= render_slot(@actions) %>
      </div>
    </header>
    """
  end
end
