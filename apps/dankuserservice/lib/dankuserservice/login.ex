defmodule DankUserService.Login do
  alias DankUserService.User

  def try(%{email: email}, password) do
    case DankUserService.HandleUser.get(%{email: email}) do
      {:error, msg} ->
        {:error, msg}
      {:ok, found} ->
        case check_password(found, password) do
          true -> 
            {:ok, "Welcome back " <> found.username <> " !"}
          _ ->
            {:error, "Invalid Password"}
        end
    end
  end

  defp check_password(user, password) do
    Comeonin.Bcrypt.checkpw(password, user.password_hash)
  end
end