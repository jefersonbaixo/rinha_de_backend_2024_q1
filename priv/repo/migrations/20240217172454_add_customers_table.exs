defmodule RinhaDeBackend2024Q1.Repo.Migrations.AddCustomersTable do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :balance, :integer
      add :limit, :integer
    end
  end
end
