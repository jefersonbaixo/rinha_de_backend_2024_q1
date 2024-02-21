defmodule RinhaDeBackend2024Q1.Customers.Get do
  alias RinhaDeBackend2024Q1.Customers.Customer
  alias RinhaDeBackend2024Q1.Repo
  alias RinhaDeBackend2024Q1.Transactions.Transaction

  import Ecto.Query

  def call(id) do
    transactions_query =
      from(t in Transaction,
        where: t.customer_id == ^id,
        order_by: [desc: t.id],
        limit: 10
      )

    case Repo.get(Customer, id) do
      nil ->
        {:error, :not_found}

      customer ->
        customer_with_limit =
          Repo.preload(customer, transactions: transactions_query)

        {:ok, customer_with_limit}
    end
  end
end
