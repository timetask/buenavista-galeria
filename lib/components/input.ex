defmodule Galeria.Components.Input do
  use BuenaVista.Component
  alias Phoenix.HTML.FormField

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
  attr :field, FormField, default: nil
  slot :inner_block

  component label(assigns) do
    ~H"""
    <label for={label_for(@field, @for)} class={@base_class}><%= render_slot(@inner_block) %></label>
    """
  end

  defp label_for(%FormField{} = field, _for), do: field.id
  defp label_for(_field, for) when is_binary(for), do: for
  defp label_for(_field, nil), do: nil

  attr :id, :string
  attr :value, :string
  variant :state, [:default, :disabled], :default

  component input(assigns) do
    ~H"""
    <input
      type="text"
      class={[@base_class, @variant_classes]}
      disabled={@state == :disabled}
      autocomplete="off"
    />
    """
  end

  attr :id, :string, default: nil
  attr :value, :string, default: nil
  variant :state, [:default, :disabled], :default
  variant :border, [:top, :all, :none], :all

  component codearea(assigns) do
    ~H"""
    <div class={[@base_class, @variant_classes]}>
      <prism-code-editor lang="css" id={@id}><%= @value %></prism-code-editor>
    </div>
    """
  end

  attr :field, FormField, required: true
  attr :options, :list, default: []
  attr :rest, :global

  slot :inner_block

  component select(assigns) do
    ~H"""
    <select class={@base_class} id={@field.id} name={@field.name} {@rest}>
      <%= for {value, text} <- @options do %>
        <option value={value} selected={@field.value == value}><%= text %></option>
      <% end %>
    </select>
    """
  end
end
