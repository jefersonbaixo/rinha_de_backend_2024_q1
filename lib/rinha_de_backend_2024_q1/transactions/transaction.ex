defmodule RinhaDeBackend2024Q1.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias RinhaDeBackend2024Q1.Customers.Customer

  @required_params [:value, :type, :description, :customer_id]

  schema "transactions" do
    field :value, :integer
    field :type, :string
    field :description, :string
    belongs_to :customer, Customer
    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
    |> validate_number(:value, greater_than: 0)
    |> validate_length(:description, max: 10)
    |> validate_length(:type, max: 1)
  end
end
