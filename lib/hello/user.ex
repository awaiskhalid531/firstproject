defmodule Hello.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.User
  schema "users" do
    field :bio, :string
    field :email, :string
    field :name, :string
    field :number_of_pets, :integer

    timestamps()
  end

  @doc false
  def changeset(%User{} =user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name ])
    |> validate_required([:name])

  end
end
