defmodule RinhaDeBackend2024Q1Web.CustomersJSON do
  use RinhaDeBackend2024Q1Web, :controller

  alias RinhaDeBackend2024Q1.Customers.Customer
  alias RinhaDeBackend2024Q1.Transactions.Transaction

  action_fallback RinhaDeBackend2024Q1Web.FallbackController

  def get(%{customer: customer}), do: data(customer)

  defp data(%Customer{} = customer) do
    %{
      saldo: %{
        total: customer.balance,
        data_extrato: DateTime.utc_now(),
        limite: customer.limit
      },
      ultimas_transacoes: Enum.map(customer.transactions, &transaction_data/1)
    }
  end

  defp transaction_data(%Transaction{} = transaction) do
    %{
      valor: transaction.value,
      tipo: transaction.type,
      descricao: transaction.description,
      realizada_em: parse_date(transaction.inserted_at)
    }
  end

  defp parse_date(date) do
    {:ok, date} = DateTime.from_naive(date, "Etc/UTC")
    date
  end
end
