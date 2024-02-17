defmodule RinhaDeBackend2024Q1Web.CustomersController do
  use RinhaDeBackend2024Q1Web, :controller

  alias RinhaDeBackend2024Q1.Customers
  alias Customers.Customer

  action_fallback RinhaDeBackend2024Q1Web.FallbackController

  def show(conn, %{"id" => id}) do
    with {:ok, %Customer{} = customer} <- Customers.get(id) do
      conn
      |> put_status(:ok)
      |> render(:show, customer: customer)
    end
  end
end
