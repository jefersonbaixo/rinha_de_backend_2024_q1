# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RinhaDeBackend2024Q1.Repo.insert!(%RinhaDeBackend2024Q1.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias RinhaDeBackend2024Q1.{Repo, Customers}

Repo.insert!(%Customers.Customer{id: 1, limit: 1000 * 100, balance: 0})
Repo.insert!(%Customers.Customer{id: 2, limit: 800 * 100, balance: 0})
Repo.insert!(%Customers.Customer{id: 3, limit: 10000 * 100, balance: 0})
Repo.insert!(%Customers.Customer{id: 4, limit: 100_000 * 100, balance: 0})
Repo.insert!(%Customers.Customer{id: 5, limit: 5000 * 100, balance: 0})
