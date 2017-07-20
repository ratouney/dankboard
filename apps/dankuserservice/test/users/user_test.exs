defmodule DankUserService.TestAddUser do
    alias DankUserService.Models.User
    alias DankUserService.Repo
    use ExUnit.Case

    setup do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    end

    @valid_set %{username: "John Doe", email: "john.doe@google.com", password: "ilovecats"}
    @other_set_samepw %{username: "Chuck Norris", email: "freedom@murica.gov.us", password: "ilovecats"}
    @other_set %{username: "Chuck Norris", email: "freedom@murica.gov.us", password: "punchisis"}
    @valid_set_other_username %{username: "Jane Doe", email: "john.doe@google.com", password: "ilovecats"}
    @valid_set_other_password %{username: "John Doe", email: "john.doe@google.com", password: "ihatedogs"}
    @valid_set_other_email %{username: "John Doe", email: "iloveloli@google.com", password: "ilovecats"}
    @password_too_short %{username: "John Doe", email: "iloveloli@google.com", password: "ilove"}
    @bonus_arg %{username: "John Doe", email: "john.doe@google.com", password: "ilovecats", yodelo: 123}
    @missing_username %{email: "john.doe@google.com", password: "ilovecats"}
    @missing_email %{username: "john.doe@google.com", password: "ilovecats"}
    @missing_password %{email: "john.doe@google.com", username: "ilovecats"}

    test "Adding a blank user" do
        assert %{valid?: false} = DankUserService.User.Registration.create(%{})
    end

    test "Adding user with invalid fields" do
        assert %{valid?: false, errors: _msg} = DankUserService.User.Registration.create(%{yodelo: "Ding"})
    end

    test "Adding a valid user but with additionnal fields" do
        assert %User{} = DankUserService.User.Registration.create(@bonus_arg)
    end

    test "Adding a valid user" do
        assert %User{} = DankUserService.User.Registration.create(@valid_set)
    end

    test "Adding an invalid user (missing username)" do
        assert %{valid?: false} = DankUserService.User.Registration.create(@missing_username)
    end

    test "Adding an invalid user (missing email)" do
        assert %{valid?: false} = DankUserService.User.Registration.create(@missing_email)
    end

    test "Adding an invalid user (missing password)" do
        assert %{valid?: false} = DankUserService.User.Registration.create(@missing_password)
    end

    test "Added user with already existing username" do
        first = DankUserService.User.Registration.create(@valid_set)
        assert %User{} = first
        second = DankUserService.User.Registration.create(@valid_set_other_email)
        assert %{valid?: false, errors: [username: {"has already been taken", []}]} = second
    end

    test "Added user with already existing email" do
        first = DankUserService.User.Registration.create(@valid_set)
        assert %User{} = first
        second = DankUserService.User.Registration.create(@valid_set_other_username)
        assert %{valid?: false, errors: [email: {"has already been taken", []}]} = second
    end

    # @tag :skip
    test "Added user with the same password" do
        first = DankUserService.User.Registration.create(@valid_set)
        second = DankUserService.User.Registration.create(@other_set_samepw)
        IO.inspect first
        IO.inspect second
        assert %User{} = first
        assert %User{} = second
    end

    test "Password is too short" do
        user = DankUserService.User.Registration.create(@password_too_short)
        assert %{valid?: false, errors: [password: {"should be at least %{count} character(s)",
               [count: 6, validation: :length, min: 6]}]} = user
    end

    test "Updating an existing user with a new email" do
        user = DankUserService.User.Registration.create(@valid_set)
        newuser = DankUserService.User.Registration.update(@valid_set_other_email, user.id)

        assert @valid_set.username == newuser.username
        assert @valid_set.password == newuser.password
        assert @valid_set_other_email.email == newuser.email
        assert user.id == newuser.id
    end

    test "Updating an existing user with a new password" do
        user = DankUserService.User.Registration.create(@valid_set)
        newuser = DankUserService.User.Registration.update(@valid_set_other_password, user.id)

        assert @valid_set.username == newuser.username
        assert @valid_set.email == newuser.email
        assert user.id == newuser.id
        refute user.password_hash == newuser.password_hash
    end

    # @tag :skip
    test "Deleting an existing user" do
        user = DankUserService.User.Registration.create(@valid_set)

        assert %User{} = DankUserService.User.Registration.delete(user)
    end

    test "Delete a non-existant user" do
        DankUserService.User.Registration.delete(%{id: "1337"})
    end
end
