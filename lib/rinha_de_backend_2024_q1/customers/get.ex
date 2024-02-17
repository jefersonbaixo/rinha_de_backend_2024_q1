defmodule RinhaDeBackend2024Q1.Customers.Get do
  alias RinhaDeBackend2024Q1.Customers.Customer
  alias RinhaDeBackend2024Q1.Repo

  def call(id) do
    case Repo.get(Customer, id) do
      nil -> {:error, :not_found}
      customer -> {:ok, customer}
    end
  end
end
