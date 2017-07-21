defmodule DankUserService.User.FetcherTest do
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(DankUserService.Repo)
  end

  defp fake_user do
    Faker.Internet.user_name
  end

  defp fake_email do
    Faker.Internet.email
  end

  defp params do
    %{username: fake_user(), email: fake_email(), password: "123456789"}
  end

  test "Get a user by ID" do
    {:ok, user} = DankUserService.User.Registration.create(params())
    {:ok, fetched_user} = DankUserService.User.Fetcher.get(%{id: user.id})

    assert fetched_user.id == user.id
  end

  test "Should return an error if id does not exist" do
    assert {:error, _msg} = DankUserService.User.Fetcher.get(%{id: Enum.random(10_000..20_000)})
  end

    test "Get a user by Email" do
    {:ok, user} = DankUserService.User.Registration.create(params())
    {:ok, fetched_user} = DankUserService.User.Fetcher.get(%{email: user.email})

    assert fetched_user.email == user.email
    assert fetched_user.id == user.id
  end

  test "Should return an error if email does not exist" do
    assert {:error, _msg} = DankUserService.User.Fetcher.get(%{email: fake_email()})
  end

  test "Get a user by Username" do
    {:ok, user} = DankUserService.User.Registration.create(params())
    {:ok, fetched_user} = DankUserService.User.Fetcher.get(%{username: user.username})

    assert fetched_user.id == user.id
    assert fetched_user.username == user.username
  end

  test "Should return an error if username does not exist" do
    assert {:error, _msg} = DankUserService.User.Fetcher.get(%{username: fake_user()})
  end

  test "Check not finding a non-existant user by id" do
    id = Enum.random(10_000..20_000)
    {:error, msg} = DankUserService.User.Fetcher.find(%{id: id}, :id)

    assert msg == "User <#{id}> not found"
  end

  test "Check finding a user by ID" do
    init = params()
    {:ok, user} = DankUserService.User.Registration.create(init)
    {:ok, found} = DankUserService.User.Fetcher.find(user, :id)

    assert found.username == init.username
    assert found.email == init.email
    assert found.id == user.id
  end

  test "Check not finding a non-existant user by username" do
    {:error, _found} = DankUserService.User.Fetcher.find(params(), :username)
  end

  test "Check finding a user by Username" do
    init = params()
    {:ok, user} = DankUserService.User.Registration.create(init)
    {:ok, found} = DankUserService.User.Fetcher.find(user, :username)

    assert found.username == init.username
    assert found.email == init.email
    assert found.id == user.id
  end

  test "Check not finding a non-existant user by email" do
    {:error, _found} = DankUserService.User.Fetcher.find(params(), :email)
  end

  test "Check finding a user by Email" do
    init = params()
    {:ok, user} = DankUserService.User.Registration.create(init)
    {:ok, found} = DankUserService.User.Fetcher.find(user, :email)

    assert found.username == init.username
    assert found.email == init.email
    assert found.id == user.id
  end
end