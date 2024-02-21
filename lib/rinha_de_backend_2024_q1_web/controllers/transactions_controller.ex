defmodule RinhaDeBackend2024Q1Web.TransactionsController do
  use RinhaDeBackend2024Q1Web, :controller

  alias RinhaDeBackend2024Q1.Customers.Customer
  alias RinhaDeBackend2024Q1.Transactions

  action_fallback RinhaDeBackend2024Q1Web.FallbackController

  def create(conn, params) do
    with {:ok, %Customer{} = customer} <- Transactions.create(params) do
      conn
      |> put_status(:ok)
      |> render(:create, customer: customer)
    end
  end
end
