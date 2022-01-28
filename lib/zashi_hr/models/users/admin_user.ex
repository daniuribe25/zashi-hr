defmodule ZashiHR.Models.Users.AdminUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "admin_users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password_hash, :string
    field :role, :string
    field :active, :boolean, default: true

    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(admin_user, attrs) do
    admin_user
    |> cast(attrs, [:email, :first_name, :last_name, :password])
    |> validate_required([:email, :first_name, :last_name, :password], message: "is required")
    |> update_change(:email, &String.downcase(&1))
    |> validate_format(:email, ~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i,
      message: "invalid"
    )
    |> unique_constraint(:email, name: :users_unique_email_index, message: "already registered")
    |> validate_length(:password,
      min: 6,
      max: 20,
      message: " should have between 6 and 20 characters"
    )
    |> validate_format(:password, ~r/^(?=.*[a-z].*)(?=.*[A-Z].*)(?=.*[0-9].*)[a-zA-Z0-9]{6,20}$/,
      message:
        "should contains at least an uppercase letter, a downcase letter, at least one number, and a special character"
    )
    |> hash_password
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    %{password_hash: password_hash} = Bcrypt.add_hash(password)
    put_change(changeset, :password_hash, password_hash)
  end

  defp hash_password(changeset), do: changeset
end
