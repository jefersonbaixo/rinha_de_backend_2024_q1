defmodule RinhaDeBackend2024Q1Web.TransactionsController do
  use RinhaDeBackend2024Q1Web, :controller

  alias RinhaDeBackend2024Q1.Transactions
  alias Transactions.Transaction

  action_fallback RinhaDeBackend2024Q1Web.FallbackController

  def create(conn, params) do
    with {:ok, %Transaction{} = transaction} <- Transactions.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, transaction: transaction)
    end
  end
end
