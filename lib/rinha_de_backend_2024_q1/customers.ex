defmodule RinhaDeBackend2024Q1.Customers do
  alias RinhaDeBackend2024Q1.Customers.Get

  defdelegate get(id), to: Get, as: :call
end
