defmodule RinhaDeBackend2024Q1.Transactions.Create do
  import Ecto.Query

  alias RinhaDeBackend2024Q1.Customers
  alias RinhaDeBackend2024Q1.Transactions
  alias Customers.Customer
  alias Transactions.Transaction
  alias RinhaDeBackend2024Q1.Repo
  alias Ecto.Multi

  def call(params) do
    case valid_params?(params) do
      {:ok, valid_params} -> execute(valid_params)
      {:error, error} -> {:error, error}
    end
  end

  def execute(
        %{customer_id: customer_id, value: value, type: :c, description: description} = params
      ) do
    customer_update =
      from Customer,
        where: [id: ^customer_id],
        update: [inc: [balance: ^(+value)]]

    transaction_insert =
      Transaction.changeset(
        %Transaction{
          value: value,
          type: :c,
          description: description,
          customer_id: customer_id
        },
        params
      )

    Multi.new()
    |> Multi.update_all(:customer_update, customer_update, [])
    |> Multi.insert(:transaction_insert, transaction_insert)
    |> Repo.transaction()
    |> case do
      {:ok, %{customer_update: _}} -> handle_success(customer_id)
      {:error, error} -> {:error, error}
    end
  end

  def execute(
        %{customer_id: customer_id, value: value, type: :d, description: description} = params
      ) do
    customer_update =
      from Customer,
        where: [id: ^customer_id],
        update: [inc: [balance: ^(-value)]]

    transaction_insert =
      Transaction.changeset(
        %Transaction{
          value: value,
          type: :d,
          description: description,
          customer_id: customer_id
        },
        params
      )

    Multi.new()
    |> Multi.update_all(:customer_update, customer_update, [])
    |> Multi.run(:check_balance, fn repo, _ ->
      check_balance(repo, customer_id)
    end)
    |> Multi.insert(:transaction_insert, transaction_insert)
    |> Repo.transaction()
    |> case do
      {:ok, %{customer_update: _}} -> handle_success(customer_id)
      {:error, :check_balance, :limit_exceeded, _} -> {:error, :limit_exceeded}
      {:error, error} -> {:error, error}
    end
  end

  defp check_balance(repo, customer_id) do
    customer = repo.get(Customer, customer_id)

    if customer.balance < -customer.max_limit do
      {:error, :limit_exceeded}
    else
      {:ok, customer}
    end
  end

  defp handle_success(customer_id) do
    customer = Repo.get(Customer, customer_id)

    {:ok,
     %Customer{
       balance: customer.balance,
       max_limit: customer.max_limit
     }}
  end

  defp valid_params?(%{
         "id" => customer_id,
         "valor" => value,
         "tipo" => type,
         "descricao" => description
       }) do
    if(
      (type == "c" ||
         type == "d") and
        is_integer(value) and
        is_integer(String.to_integer(customer_id)) and
        (description != nil and String.length(description) <= 10 && String.length(description) > 0)
    ) do
      {:ok,
       %{
         customer_id: String.to_integer(customer_id),
         value: value,
         type: String.to_atom(type),
         description: description
       }}
    else
      {:error, :invalid_params}
    end
  end

  defp valid_params?(_), do: {:error, :invalid_params}
end
