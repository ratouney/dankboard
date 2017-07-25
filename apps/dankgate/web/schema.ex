defmodule Dankgate.Schema do
    use Absinthe.Schema
    import_types Dankgate.Schema.Types

    query do
        field :users, list_of(:user) do
            resolve &Dankgate.UserResolver.all/2
        end

        field :find_user_by_id, type: :user do
            arg :id, non_null(:id)
            resolve &Dankgate.UserResolver.find/2
        end

        field :find_user_by_username, type: :user do
            arg :username, non_null(:string)
            resolve &Dankgate.UserResolver.find/2
        end

        field :find_user_by_email, type: :user do
            arg :email, non_null(:string)
            resolve &Dankgate.UserResolver.find/2
        end
    end

    input_object :update_user_params do
        field :username, :string
        field :email, :string
        field :password, :string
        field :github_key, :string
    end

    mutation do
        field :create_user, type: :user do
            arg :username, non_null(:string)
            arg :email, non_null(:string)
            arg :password, non_null(:string)
            arg :github_key, :string

            resolve &Dankgate.UserResolver.create/2
        end

        field :update_user, type: :user do
            arg :id, non_null(:id)
            arg :user, :update_user_params

            resolve &Dankgate.UserResolver.update/2
        end

        field :delete_user, type: :user do
            arg :id, non_null(:id)

            resolve &Dankgate.UserResolver.delete/2
        end
    end
end