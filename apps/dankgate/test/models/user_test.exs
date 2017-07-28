defmodule Dankgate.UserTest do
  use Dankgate.ModelCase

  alias Dankgate.User

  @valid_attrs %{email: "some content", github_key: "some content", password_hash: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
