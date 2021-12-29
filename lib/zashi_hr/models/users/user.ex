defmodule ZashiHR.Models.Users.User do
  alias ZashiHR.Models.Users.{UserEducation
    # , UserAddress, UserContact, UserJobLog, UserTimeOffHistory, UserTimeOffRequest
  }
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password_hash, :string
    field :hire_date, :date
    field :position, :string
    field :birth_date, :date
    field :gender, :string
    field :marital_status, :string
    field :last_invitation_at, :naive_datetime
    field :active, :boolean, default: true
    field :role, :string, default: "common"

    field :password, :string, virtual: true

    # has_one :user_address, UserAddress
    # has_one :user_contact, UserContact
    has_many :user_educations, UserEducation
    # has_many :user_job_logs, UserJobLog
    # has_many :user_timeoff_history, UserTimeOffHistory
    # has_many :user_time_off_requests, UserTimeOffRequest

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :first_name, :last_name, :password, :hire_date, :position, :birth_date, :gender, :marital_status])
    |> validate_required([:email, :first_name, :last_name, :hire_date, :position], message: "is required")
    |> update_change(:email, &String.downcase(&1))
    |> validate_format(:email, ~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i, message: "invalid")
    |> unique_constraint(:email, name: :users_unique_email_index, message: "already registered")
    |> validate_length(:password, min: 6, max: 20, message: " should have between 6 and 20 characters")
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
