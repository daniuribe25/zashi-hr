defmodule ZashiHR.Models.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :accept_terms, :boolean, default: false
    field :description, :string
    field :name, :string
    field :email, :string
    field :logo, :string
    field :role, :string, default: "employer"
    field :password_hash, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    field :phone, :string
    field :website, :string
    field :active, :boolean, default: true
    field :post_credits, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:email, :password, :password_confirmation, :name, :phone, :role, :description, :logo, :website, :accept_terms])
    |> validate_required([:email, :name, :accept_terms])
    |> validate_accept_terms(:accept_terms)
    |> update_change(:email, &String.downcase(&1))
    |> validate_format(:email, ~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i, message: "invalid")
    |> unique_constraint(:email, name: :companies_unique_email_index, message: "already registered")
    |> validate_email_unique(:email)
    |> unique_constraint(:name, name: :companies_unique_name_index, message: "already registered")
    |> unique_constraint(:phone, name: :companies_unique_phone_index, message: "already registered")
    |> validate_length(:password, min: 6, max: 20, message: " debe tener de 6 a 20 caracteres")
    |> validate_format(:password, ~r/^(?=.*[a-z].*)(?=.*[A-Z].*)(?=.*[0-9].*)[a-zA-Z0-9]{6,20}$/,
      message:
      "it should contains at least an uppercase letter, a downcase letter, at least one number, and a special character"
    )
    |> validate_confirmation(:password, message: "don't match")
    |> hash_password
  end

  def validate_email_unique(changeset, field) do
    case get_field(changeset, field) |> ZashiHR.Services.Users.get_by_email() do
      %ZashiHR.Models.Users.User{} = _ -> add_error(changeset, :email, "already registered as job seeker")
      _ -> changeset
    end
  end

  def validate_phone_unique(changeset, field) do
    case get_field(changeset, field) |> ZashiHR.Services.Users.get_by_phone() do
      %ZashiHR.Models.Users.User{} = _ -> add_error(changeset, :phone, "already registered as job seeker")
      _ -> changeset
    end
  end

  def validate_accept_terms(changeset, field) do
    case get_field(changeset, field) do
      false = _ -> add_error(changeset, :accept_terms, ", you should accept terms and conditions before creating an account")
      _ -> changeset
    end
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    %{password_hash: password_hash} = Bcrypt.add_hash(password)
    put_change(changeset, :password_hash, password_hash)
  end

  defp hash_password(changeset), do: changeset
end
