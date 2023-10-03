defmodule Galeria.Components.Input do
  use BuenaVista.Component

  attr :for, :string, default: nil
  slot :inner_block

  component label(assigns) do
    ~H"""
    <label for={@for} class={@base_class}><%= render_slot(@inner_block) %></label>
    """
  end

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
