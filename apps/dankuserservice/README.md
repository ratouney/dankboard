# DankUserService

DankUserService is a User database that can be controlled through the given client (DankUserService.Client) 
First, start an IEx console with ```iex -S mix```. 
Then run the applications server :
```elixir
  iex(1)> {:ok, pid} = DankUserService.Server.start_link()
  {:ok, #PID<123.123>}
```

You can connected to the server using the module's name as a PID ```DankUserService.Server``` (they are linked) but this syntax allows you to keep the ServerPID stored in a variable.
Once this is done, you can use the different commands to access the data you want : 

```elixir
  iex(2)> params = %{username: "John Doe", email: "john.doe@google.com", password: "peacebird"}
  %{username: "John Doe", email: "john.doe@google.com", password: "peacebird"}

  iex(3)> user = DankUserService.Client.create(pid, params)
  %DankUserService.Models.User{...}

  iex(4)> DankUserService.Client.update(pid, user.id, %{email: "doe.other.email@google.com"})
  %DankUserService.Models.User{...}

  iex(5)> DankUserService.Client.Get.id(pid, id)
  %DankUserService.Models.User{...}

  iex(5)> DankUserService.Client.delete(pid, id)
  %DankUserService.Models.User{...}
```

Any case of error, would return a result in the form of {:error, error_info}

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `DankUserService` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:dankuserservice, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/DankUserService](https://hexdocs.pm/DankUserService).

