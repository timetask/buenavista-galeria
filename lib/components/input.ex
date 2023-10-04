defmodule Galeria.Components.Input do
  use BuenaVista.Component

  slot :inner_block

  component fieldset(assigns) do
    ~H"""
    <div class={@base_class}><%= render_slot(@inner_block) %></div>
    """
  end

  variant :direction, [:vertical, :horizontal], :vertical
  slot :inner_block

  component group(assigns) do
    ~H"""
    <div class={[@base_class, @variant_classes]}><%= render_slot(@inner_block) %></div>
    """
  end

  attr :for, :string, default: nil
  slot :inner_block

  component label(assigns) do
    ~H"""
    <label for={@for} class={@base_class}><%= render_slot(@inner_block) %></label>
    """
  end

  slot :inner_block

  attr :id, :string, default: nil
  attr :options, :list, default: []

  component select(assigns) do
    ~H"""
    <select class={@base_class} id={@id}>
      <%= for {value, text} <- @options do %>
        <option value={value}><%= text %></option>
      <% end %>
    </select>
    """
  end
end
