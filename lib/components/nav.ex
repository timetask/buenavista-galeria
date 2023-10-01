defmodule Galeria.Components.Nav do
  use BuenaVista.Component

  defmodule Item do
    defstruct [:id, :url, :text]
  end

  variant :direction, [:vertical, :horizontal], :vertical

  attr :items, :list, default: []
  attr :selected_item, Item, default: nil

  classes [:item_class, :item_selected_class]

  component nav_list(assigns) do
    ~H"""
    <nav class={[@base_class, @variant_classes]}>
      <%= for %Item{} = item <- @items do %>
        <.link
          patch={item.url}
          class={[@item_class, selected_entry?(@selected_item, item) && @item_selected_class]}
        >
          <%= item.text %>
        </.link>
      <% end %>
    </nav>
    """
  end

  defp selected_entry?(%Item{id: item_id}, %Item{id: item_id}), do: true
  defp selected_entry?(_item_a, _item_b), do: false
end
