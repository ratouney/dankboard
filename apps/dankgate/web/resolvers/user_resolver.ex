defmodule Dankgate.UserResolver do
  @server_name DankUserService.Server

  def all(_args, _info) do
    {:ok, DankUserService.Client.Get.all(@server_name)}
  end

  def find(%{id: id}, _info) do
    case DankUserService.Client.Get.id(@server_name, id) do
      {:error, msg} ->
        {:error, msg}
      :fatal_error ->
        raise "Kill the student"
      user ->
        {:ok, user}
    end
  end

  def find(%{username: username}, _info) do
    case DankUserService.Client.Get.username(@server_name, username) do
      {:error, msg} ->
        {:error, msg}
      :fatal_error ->
        raise "Kill the student"
      user ->
        {:ok, user}
    end
  end

  def find(%{email: email}, _info) do
    case DankUserService.Client.Get.email(@server_name, email) do
      {:error, msg} ->
        {:error, msg}
      :fatal_error ->
        raise "Kill the student"
      user ->
        {:ok, user}
    end
  end

  def create(args, _info) do
    case DankUserService.Client.create(@server_name, args) do
      {:error, msg} ->
        %{valid?: false, errors: extract} = msg
        {:error, Dankgate.Error.ectoerrs_to_string(extract)}
      :fatal_error ->
        raise "Kill the student"
      user ->
        {:ok, user}
    end
  end

  def update(%{id: id, user: params}, _info) do
    case DankUserService.Client.update(@server_name, id, params) do
      {:error, msg} ->
        %{valid?: false, errors: extract} = msg
        {:error, Dankgate.Error.ectoerrs_to_string(extract)}
      :fatal_error ->
          raise "Kill the student"
      user ->
        user
    end
  end

  def delete(%{id: id}, _info) do
    case DankUserService.Client.delete(@server_name, id) do
      {:error, msg} ->
        {:error, msg}
      :fatal_error ->
        raise "Kill the student"
      user ->
        user
    end
  end
end