defmodule Dankgate.Schema.Types do
    use Absinthe.Schema.Notation

    object :user do
        field :id, :id
        field :username, :string
        field :email, :string
        field :github_key, :string
    end
end