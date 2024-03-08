defmodule RinhaDeBackend2024Q1Web.TransactionsJSON do
  use RinhaDeBackend2024Q1Web, :controller

  alias RinhaDeBackend2024Q1.Customers.Customer

  action_fallback RinhaDeBackend2024Q1Web.FallbackController

  def create(%{customer: customer}), do: data(customer)

  defp data(%Customer{} = customer) do
    %{
      limite: customer.max_limit,
      saldo: customer.balance
    }
  end
end
