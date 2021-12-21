defmodule ZashiHR.Services.Helpers.Queries do
  import Ecto.Query, only: [from: 2], warn: true

  def filter_search(model, filter, query, integer_list, array_list, operator) do
    Map.keys(filter)
      |> Enum.reduce(query, fn key, query ->
        if key != :or do
          type = cond do
            key in integer_list -> :integer
            key in array_list -> :array
            true -> :string
          end
          filter_by(model, filter, query, key, type, operator)
        else
          filter_or(model, filter, query, integer_list, array_list)
        end
    end)
  end

  defp filter_or(model, filter, query, integer_list, array_list) do
    if Map.has_key?(filter, :or) do
      filter.or
        |> Enum.with_index
        |> Enum.reduce(query, fn {f, index}, query ->
          operator = if index !== 0, do: :or, else: :and
          filter_search(model, f, query, integer_list, array_list, operator)
      end)
    else
      query
    end
  end

  defp filter_by(model, filter, query, key, :string, operator) do
    if Map.has_key?(filter, key) do
      query = contains(filter, query, key, model, operator)
      eq(filter, query, key, model, operator)
    else
      query
    end
  end

  defp filter_by(model, filter, query, key, :integer, operator) do
    if Map.has_key?(filter, key) do
      query = gte(filter, query, key, model, operator)
      query = gt(filter, query, key, model, operator)
      query = lte(filter, query, key, model, operator)
      lt(filter, query, key, model, operator)
    else
      query
    end
  end

  defp filter_by(model, filter, query, key, :array, operator) do
    if Map.has_key?(filter, key) do
      contains_in_array(filter, query, key, model, operator)
    else
      query
    end
  end

  defp contains(filter, query, key, as, :and) do
    if Map.has_key?(filter[key], :contains), do: (from [{^as, p}] in query, where: ilike(field(p, ^key), ^"%#{filter[key].contains}%")), else: query
  end

  defp contains(filter, query, key, as, :or) do
    if Map.has_key?(filter[key], :contains), do: (from [{^as, p}] in query, or_where: ilike(field(p, ^key), ^"%#{filter[key].contains}%")), else: query
  end

  defp contains_in_array(filter, query, key, as, :and) do
    if Map.has_key?(filter[key], :contains) do
      from([{^as, p}] in query, where: fragment("exists (select * from unnest(?) tag where tag ilike ?)", field(p, ^key), ^("%#{filter[key].contains}%")))
    else
      query
    end
  end

  defp contains_in_array(filter, query, key, as, :or) do
    if Map.has_key?(filter[key], :contains) do
      from([{^as, p}] in query, or_where: fragment("exists (select * from unnest(?) tag where tag ilike ?)", field(p, ^key), ^("%#{filter[key].contains}%")))
    else
      query
    end
  end

  defp eq(filter, query, key, as, :and) do
    if Map.has_key?(filter[key], :eq), do: (from [{^as, p}] in query, where: field(p, ^key) == ^filter[key].eq), else: query
  end

  defp eq(filter, query, key, as, :or) do
    if Map.has_key?(filter[key], :eq), do: (from [{^as, p}] in query, or_where: field(p, ^key) == ^filter[key].eq), else: query
  end

  defp gte(filter, query, key, as, :and) do
    if Map.has_key?(filter[key], :gte), do: (from [{^as, p}] in query, where: field(p, ^key) >= ^filter[key].gte), else: query
  end

  defp gte(filter, query, key, as, :or) do
    if Map.has_key?(filter[key], :gte), do: (from [{^as, p}] in query, or_where: field(p, ^key) >= ^filter[key].gte), else: query
  end

  defp gt(filter, query, key, as, :and) do
    if Map.has_key?(filter[key], :gt), do: (from [{^as, p}] in query, where: field(p, ^key) > ^filter[key].gt), else: query
  end

  defp gt(filter, query, key, as, :or) do
    if Map.has_key?(filter[key], :gt), do: (from [{^as, p}] in query, or_where: field(p, ^key) > ^filter[key].gt), else: query
  end

  defp lte(filter, query, key, as, :and) do
    if Map.has_key?(filter[key], :lte), do: (from [{^as, p}] in query, where: field(p, ^key) <= ^filter[key].lte), else: query
  end

  defp lte(filter, query, key, as, :or) do
    if Map.has_key?(filter[key], :lte), do: (from [{^as, p}] in query, or_where: field(p, ^key) <= ^filter[key].lte), else: query
  end

  defp lt(filter, query, key, as, :and) do
    if Map.has_key?(filter[key], :lt), do: (from [{^as, p}] in query, where: field(p, ^key) < ^filter[key].lt), else: query
  end

  defp lt(filter, query, key, as, :or) do
    if Map.has_key?(filter[key], :lt), do: (from [{^as, p}] in query, or_where: field(p, ^key) < ^filter[key].lt), else: query
  end
end
