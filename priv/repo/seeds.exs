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

Repo.insert!(%Customers.Customer{limit: 100_000, balance: 0})
Repo.insert!(%Customers.Customer{limit: 80000, balance: 0})
Repo.insert!(%Customers.Customer{limit: 1_000_000, balance: 0})
Repo.insert!(%Customers.Customer{limit: 10_000_000, balance: 0})
Repo.insert!(%Customers.Customer{limit: 500_000, balance: 0})
