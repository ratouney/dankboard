defmodule Dankgate.UserResolver do
  @server_name DankUserService.Server

  def all(_args, _info) do
    {:ok, DankUserService.Client.Get.all(@server_name)}
  end

  def find(%{id: id}, _info) do
    DankUserService.Client.Get.id(@server_name, id)
  end

  def find(%{username: username}, _info) do
    DankUserService.Client.Get.username(@server_name, username)
  end

  def find(%{email: email}, _info) do
    DankUserService.Client.Get.id(@server_name, email)
  end

  def create(args, _info) do
    @server_name
    |> DankUserService.Client.create(args)
    |> handle_answer()
  end

  def update(%{id: id, user: params}, _info) do
    @server_name
    |> DankUserService.Client.update(id, params)
    |> handle_answer()
  end

  def delete(%{id: id}, _info) do
    case DankUserService.Client.delete(@server_name, id) do
      {:ok, user} ->
        user
      {:error, msg} ->
        {:error, msg}
    end
  end

  defp handle_answer(answer) do
    case answer do
      {:error, %{valid?: false, errors: err}} ->
        {:error, Dankgate.Error.ectoerrs_to_string(err)}
      valid_resp ->
        valid_resp
    end
  end
end