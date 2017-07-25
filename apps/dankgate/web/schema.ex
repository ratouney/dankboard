defmodule Dankgate.Schema do
    use Absinthe.Schema
    import_types Dankgate.Schema.Types

    query do
        field :users, list_of(:user) do
            resolve &Dankgate.UserResolver.all/2
        end
    end
end