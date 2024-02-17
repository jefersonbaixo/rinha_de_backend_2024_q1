defmodule RinhaDeBackend2024Q1Web.CustomersJson do
  use RinhaDeBackend2024Q1Web, :controller

  alias RinhaDeBackend2024Q1.Customers
  alias Customers.Customer

  action_fallback RinhaDeBackend2024Q1Web.FallbackController

  def show(%{customer: customer}), do: %{data: data(customer)}

  defp data(%Customer{} = customer) do
    %{
      saldo: %{
        total: customer.balance,
        data_extrato: DateTime.utc_now(),
        limite: customer.limit
      },
      ultimas_transacoes: customer.transactions
    }
  end
end
