defmodule ZashiHR.Services.UserContacts do
  @moduledoc """
  The UserContacts context.
  """

  import Ecto.Query, warn: false
  alias ZashiHR.Repo
  alias ZashiHR.Models.Users.UserContact

  @spec data :: Dataloader.Ecto.t()
  def data(), do: Dataloader.Ecto.new(ZashiHR.Repo, query: &query/2)
  def query(queryable, _params), do: queryable

  def list do
    Repo.all(UserContact)
  end

  def get(id), do: Repo.get(UserContact, id)

  def get_by_user_id(user_id), do: Repo.get_by(UserContact, user_id: user_id)

  def create(attrs \\ %{}) do
    %UserContact{}
    |> Ecto.Changeset.change(attrs)
    |> UserContact.changeset(attrs)
    |> Repo.insert()
  end

  def update(%UserContact{} = user_contact, attrs) do
    user_contact
    |> Ecto.Changeset.change(attrs)
    |> Repo.update()
  end

  def delete(%UserContact{} = user_contact) do
    Repo.delete(user_contact)
  end

  def change(%UserContact{} = user_contact, attrs \\ %{}) do
    UserContact.changeset(user_contact, attrs)
  end
end
