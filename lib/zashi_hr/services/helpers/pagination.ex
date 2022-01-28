defmodule ZashiHR.Services.Helpers.Pagination do
  import Ecto.Query, only: [from: 2], warn: true

  def paginate(%{page: page, size: size}, query) do
    if size !== 0 do
      from query,
        limit: ^size,
        offset: ^(page * size)
    else
      query
    end
  end
end
