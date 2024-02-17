defmodule RinhaDeBackend2024Q1.Transactions do
  alias RinhaDeBackend2024Q1.Transactions.Create

  defdelegate create(params), to: Create, as: :call
end
