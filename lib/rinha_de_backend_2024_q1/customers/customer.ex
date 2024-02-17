defmodule RinhaDeBackend2024Q1.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  alias RinhaDeBackend2024Q1.Transactions.Transaction

  @required_params [:balance, :limit]

  schema "customers" do
    field :balance, :integer
    field :limit, :integer
    has_many :transactions, Transaction
  end

  @doc false
  def changeset(customer \\ %__MODULE__{}, attrs) do
    customer
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
  end
end
