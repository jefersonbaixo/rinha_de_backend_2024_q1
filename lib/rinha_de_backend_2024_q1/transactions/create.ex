defmodule RinhaDeBackend2024Q1.Transactions.Create do
  alias RinhaDeBackend2024Q1.Customers
  alias RinhaDeBackend2024Q1.Transactions
  alias Customers.Customer
  alias Transactions.Transaction
  alias RinhaDeBackend2024Q1.Repo
  alias Ecto.Multi

  def call(%{customer_id: customer_id, value: value, type: type} = params) do
    customer = Customers.Get.call(customer_id)

    case customer do
      {:error, :not_found} ->
        {:error, :not_found}

      {:ok, customer} ->
        if type == "d" and abs(customer.balance - value) < customer.limit do
          {:error, :limit_exceeded}
        else
          Multi.new()
          |> update_customer(customer, value, type)
          |> process_transaction(params)
          |> Repo.transaction()
          |> handle_result()
        end
    end
  end

  def update_customer(multi, customer, value, type) do
    new_balance =
      if type == "d" do
        customer.balance - value
      else
        customer.balance + value
      end

    changeset = Customer.changeset(customer, %{balance: new_balance})
    Multi.update(multi, :update_customer, changeset)
  end

  def process_transaction(multi, transaction) do
    changeset = Transaction.changeset(%Transaction{}, transaction)
    Multi.insert(multi, :transaction, changeset)
  end

  defp handle_result({:ok, _result} = result), do: result
  defp handle_result({:error, _, reason, _}), do: {:error, reason}
end
