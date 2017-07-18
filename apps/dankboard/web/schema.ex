defmodule Dankboard.Schema do
    use Absinthe.Schema
    import_types Dankboard.Schema.Types

    query do
        field :user, type: :user do
            arg :id, non_null(:id)

            resolver &Dankboard.UserResolver.find/2
        end

        field :users, list_of(:user) do
            resolve &Dankboard.UserResolver.all/2
        end
    end

    input_object :update_user_params do
        field :name, non_null(:string)
        field :email, non_null(:string)
        field :telnum, :string
    end

    mutation do
        field :create_user, type: :user do
            arg :name, non_null(:string)
            arg :email, non_null(:string)
            arg :telnum, :string

            resolve &Dankboard.UserResolver.create/2
        end

        field :update_user, type: :user do
            arg :id, non_null(:integer)
            arg :user, :update_user_params

            resolve &Dankboard.UserResolver.update/2
        end
    end

end