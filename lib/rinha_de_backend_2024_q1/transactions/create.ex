defmodule RinhaDeBackend2024Q1.Transactions.Create do
  alias RinhaDeBackend2024Q1.Customers
  alias RinhaDeBackend2024Q1.Transactions
  alias Customers.Customer
  alias Transactions.Transaction
  alias RinhaDeBackend2024Q1.Repo
  alias Ecto.Multi

  def call(params) do
    if valid_params?(params) do
      execute(params)
    else
      {:error, :invalid_params}
    end
  end

  def execute(%{"id" => customer_id, "valor" => value, "tipo" => type, "descricao" => _} = params) do
    customer = Repo.get(Customer, customer_id)

    case customer do
      nil ->
        {:error, :not_found}

      customer ->
        if type == "d" and customer.balance - value < customer.limit * -1 do
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
    IO.inspect(transaction)

    changeset =
      Transaction.changeset(
        %Transaction{
          customer_id: Integer.parse(transaction["id"]) |> elem(0),
          value: transaction["valor"],
          type: transaction["tipo"],
          description: transaction["descricao"]
        },
        transaction
      )

    Multi.insert(multi, :transaction, changeset)
  end

  defp handle_result(
         {:ok, %{transaction: %Transaction{}, update_customer: %Customer{} = customer}}
       ) do
    {:ok, %Customer{balance: customer.balance, limit: customer.limit}}
  end

  defp handle_result({:error, _, reason, _}), do: {:error, reason}

  defp valid_params?(%{"id" => id, "valor" => value, "tipo" => type, "descricao" => description}) do
    is_integer(id) and
      is_integer(value) and
      (type == "c" ||
         type == "d") and
      description |> String.length() <= 10
  end
end
