defmodule ZashiHR.Services.Helpers.OrderBy do
  import Ecto.Query, only: [from: 2], warn: true

  def sort(order_by, query) do
    sort_by_list =
      Map.keys(order_by)
      |> Enum.reduce(%{}, fn key, list ->
        Map.put(list, String.to_atom(String.downcase(order_by[key].order)), key)
      end)

    from query, order_by: ^Map.to_list(sort_by_list)
  end
end
