defmodule Dankgate.Router do
  use Dankgate.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  forward "/api", Absinthe.Plug,
    schema: Dankgate.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: Dankgate.Schema
end
