defmodule ZashiHR.Services.ContactMessages do
  @moduledoc """
  The ContactMessages context.
  """

  import Ecto.Query, warn: false
  alias ZashiHR.Repo

  alias ZashiHR.Models.ContactMessages.ContactMessage

  def list do
    Repo.all(ContactMessage)
  end

  def get(id), do: Repo.get(ContactMessage, id)

  def create(attrs \\ %{}) do
    %ContactMessage{}
    |> ContactMessage.changeset(attrs)
    |> Repo.insert()
  end

  def update(%ContactMessage{} = contact_message, attrs) do
    contact_message
    |> ContactMessage.changeset(attrs)
    |> Repo.update()
  end

  def delete(%ContactMessage{} = contact_message) do
    Repo.delete(contact_message)
  end

  def change(%ContactMessage{} = contact_message, attrs \\ %{}) do
    ContactMessage.changeset(contact_message, attrs)
  end
end
