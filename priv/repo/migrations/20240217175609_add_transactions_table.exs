defmodule RinhaDeBackend2024Q1.Repo.Migrations.AddTransactionsTable do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :value, :integer
      add :type, :string, size: 1
      add :description, :string, size: 10
      add :customer_id, references(:customers)
      timestamps()
    end
  end
end
