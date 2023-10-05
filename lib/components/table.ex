defmodule Galeria.Components.Table do
  use BuenaVista.Component

  attr :rows, :list, default: []

  slot :col, required: true do
    attr :label, :string
  end

  classes [:th_class, :td_class]

  component table(assigns) do
    ~H"""
    <table class={[@base_class, @variant_classes]}>
      <thead>
        <th :for={col <- @col} class={@th_class}>
          <%= col.label %>
        </th>
      </thead>
      <tbody>
        <tr :for={row <- @rows}>
          <td :for={col <- @col} class={@td_class}>
            <%= render_slot(col, row) %>
          </td>
        </tr>
      </tbody>
    </table>
    """
  end
end
