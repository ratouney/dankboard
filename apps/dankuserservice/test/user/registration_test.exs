defmodule DankUserService.User.RegistrationTest do
  use ExUnit.Case, async: true

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(DankUserService.Repo)
  end

  defp fake_user do
    Faker.Internet.user_name
  end

  defp fake_email do
    Faker.Internet.email
  end

  defp fake_pass do
    Faker.Lorem.word <> Faker.Lorem.word <> Faker.Lorem.word
  end

  defp params do
    %{username: fake_user(), email: fake_email(), password: fake_pass()}
  end

  test "Create a normal user" do
      init = params()
      {:ok, user} = DankUserService.User.Registration.create(init)

      assert user.username == init.username
  end

  test "Create a blank user" do
      {:error, change} = DankUserService.User.Registration.create(%{})

      %{valid?: false, errors: err} = change
      assert err == [ 
                      username: {"can't be blank", [validation: :required]},
                      email: {"can't be blank", [validation: :required]},
                      password: {"can't be blank", [validation: :required]}
                    ]
  end

  test "Create a user without username" do
    init = %{email: fake_email(), password: fake_pass()}

    {:error, change} = DankUserService.User.Registration.create(init)
      %{valid?: false, errors: err} = change
    assert err == [ 
                      username: {"can't be blank", [validation: :required]}, 
                  ]
  end

  test "Create a user without password" do
    init = %{email: fake_email(), username: fake_user()}

    {:error, change} = DankUserService.User.Registration.create(init)
    %{valid?: false, errors: err} = change
    assert err == [ 
                      password: {"can't be blank", [validation: :required]}, 
                  ]
  end

  test "Create a user without email" do
    init = %{password: fake_pass(), username: fake_user()}

    {:error, change} = DankUserService.User.Registration.create(init)
    %{valid?: false, errors: err} = change
    assert err == [ 
                      email: {"can't be blank", [validation: :required]}, 
                  ]
  end

  test "Create user with an existing username" do
    init = params()
    alt = %{username: init.username, email: fake_email(), password: fake_pass()}

    {:ok, _first_occurence} = DankUserService.User.Registration.create(init)
    {:error, change} = DankUserService.User.Registration.create(alt)
    %{valid?: false, errors: err} = change
    assert err == [
                    username: {"has already been taken", []}
                 ]
  end

  test "Create user with an existing email" do
    init = params()
    alt = %{email: init.email, username: fake_user(), password: fake_pass()}

    {:ok, _first_occurence} = DankUserService.User.Registration.create(init)
    {:error, change} = DankUserService.User.Registration.create(alt)
    %{valid?: false, errors: err} = change
    assert err == [
                    email: {"has already been taken", []}
                 ]
  end

  test "Creating a user with the same password" do
    first = params()
    second = %{email: fake_email(), username: fake_user(), password: first.password}
    {:ok, first_user} = DankUserService.User.Registration.create(first)
    {:ok, second_user} = DankUserService.User.Registration.create(second)

    assert first_user.password == second_user.password
  end

  test "Deleting a user" do
    init = params()
    {:ok, user} = DankUserService.User.Registration.create(init)

    {:ok, _deleted_user} = DankUserService.User.Registration.delete(%{id: user.id})
  end

  test "Deleting a user that doesn't exist" do
    lfid = Enum.random(10_000..20_000)
    assert_raise RuntimeError, 
        "User <" <> to_string(lfid) <> "> not found",
        fn -> DankUserService.User.Registration.delete(%{id: lfid}) end
  end

  test "Delete a user that has already been deleted" do
    {:ok, user} = DankUserService.User.Registration.create(params())
    {:ok, user} = DankUserService.User.Registration.delete(%{id: user.id})
    assert_raise RuntimeError, 
        "User <" <> to_string(user.id) <> "> not found",
        fn -> DankUserService.User.Registration.delete(%{id: user.id}) end
  end

  test "Updating a user with new username" do
    init = params()
    {:ok, user} = DankUserService.User.Registration.create(init)
    {:ok, updated_user} = DankUserService.User.Registration.update(%{init | username: "Yolotronisateur"}, user.id)

    assert user.id == updated_user.id
    refute user.username == updated_user.username
    assert user.email == updated_user.email
    assert user.password == updated_user.password
  end

  test "Updating a user with new email" do
    init = params()
    {:ok, user} = DankUserService.User.Registration.create(init)
    {:ok, updated_user} = DankUserService.User.Registration.update(%{init | email: "Yolotronisateur@epitech.eu"}, user.id)

    assert user.id == updated_user.id
    assert user.username == updated_user.username
    refute user.email == updated_user.email
    assert user.password == updated_user.password
  end

  test "Updating a user with new password" do
    init = params()
    {:ok, user} = DankUserService.User.Registration.create(init)
    {:ok, updated_user} = DankUserService.User.Registration.update(%{init | password: "epitech"}, user.id)

    assert user.id == updated_user.id
    assert user.username == updated_user.username
    assert user.email == updated_user.email
    refute user.password == updated_user.password
  end

  test "Updating a user with an existing username" do
    first = params()
    {:ok, _first_user} = DankUserService.User.Registration.create(first)
    second = params()
    {:ok, second_user} = DankUserService.User.Registration.create(second)

    existing = %{second | username: first.username}
    {:error, changeval} = DankUserService.User.Registration.update(existing, second_user.id)
    %{valid?: false, errors: err} = changeval

    assert err == [username: {"has already been taken", []}]
  end

  test "Updating a user with an existing email" do
    first = params()
    {:ok, _first_user} = DankUserService.User.Registration.create(first)
    second = params()
    {:ok, second_user} = DankUserService.User.Registration.create(second)

    existing = %{second | email: first.email}
    {:error, changeval} = DankUserService.User.Registration.update(existing, second_user.id)
    %{valid?: false, errors: err} = changeval

    assert err == [email: {"has already been taken", []}]
  end

  test "Updating a non-existant user" do
    sample = params()
    lfid = Enum.random(10_000..20_000)

    assert_raise Ecto.NoResultsError, 
        "expected at least one result but got none in query:\n" <> 
        "\nfrom u in DankUserService.Models.User,\n  where: u.id == ^" <> 
        to_string(lfid) <> "\n",
        fn -> DankUserService.User.Registration.update(sample, lfid) end
  end

  test "Updating user with an invalid password" do
    init = params()
    {:ok, user} = DankUserService.User.Registration.create(init)
    alt = %{init | password: "short"}
    {:error, changeval} = DankUserService.User.Registration.update(alt, user.id)
    %{valid?: false,  errors: err} = changeval
    
    assert err == [
      password: {"should be at least %{count} character(s)",
      [count: 6, validation: :length, min: 6]}
                  ]
  end
end