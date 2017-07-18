# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Dankboard.Repo.insert!(%Dankboard.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#

alias Dankboard.Repo
alias Dankboard.User

defmodule Filldb do
    def randuser do
        %User{
            name: Faker.Name.first_name <> " " <> Faker.Name.last_name,
            email: Faker.Internet.email,
        }
    end
end

for _ <- 1..3 do
    Repo.insert!(Filldb.randuser())
end
