defmodule DankUserService.ClientTest do
  use ExUnit.Case, async: false

  setup do
    IO.puts "#{inspect __MODULE__}: setup is getting called."
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(DankUserService.Repo)
  end

  @john %{username: "John Doe", email: "john.doe@google.com", password: "ilovebirds"}
  @jane %{username: "Jane Doe", email: "jane.doe@google.com", password: "ilovebirds"}

  test "Starting and Shutting down server" do
    {:ok, pid} = DankUserService.Client.start_server
    assert true == Process.alive?(pid)

    DankUserService.Client.close_server(pid)
    refute true == Process.alive?(pid)
  end

  test "Asking the API to create a user" do
    {:ok, pid} = DankUserService.Client.start_server
    assert true == Process.alive?(pid)

    {:ok, user} = DankUserService.Client.create(pid, @john)
  end
end