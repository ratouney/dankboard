defmodule Dankboard.Router do
  use Dankboard.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Dankboard do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  forward "/api", Absinthe.Plug,
    schema: Dankboard.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: Dankboard.Schema


  # Other scopes may use custom stacks.
  # scope "/api", Dankboard do
  #   pipe_through :api
  # end
end
