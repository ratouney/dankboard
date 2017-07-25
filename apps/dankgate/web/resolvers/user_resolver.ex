defmodule Dankgate.UserResolver do
  @server_name DankUserService.Server

  def all(_args, _info) do
    {:ok, DankUserService.Client.Get.all(@server_name)}
  end
end