defmodule DankUserService.Client do
  use GenServer
  @moduledoc """
  A module made to communicate with the DankUserService.
   
  This module handles changes made to the User database.
  To recieve data from it, use DankUserService.Client.Get

  The default PID is linked to the server module name, you can use it like thi :
      iex(1)> DankUserService.Client.delete(DankUserService.Server, 1)
  (this will delete the user with the ID = 1)

  """ 

  @doc """
    Send a request to the database to create a user with the given params

    Param is a map that will contain all the new users informations.
        iex(1)> params = %{username: "John Doe", email: "john.doe@elixir.ex", password: "notpassword"}
        %{username: "John Doe", email: "john.doe@elixir.ex", password: "notpassword"}
        iex(2)> DankUserService.Client.create(params)

    After being validated by DankUserService.Models.User.changeset/2.

    If successfull, it will return a tuple in the form of : 
        {:ok, %DankUserService.Models.User{...}}
    Else it will return an error as a string :
        {:error, ...cause...}
  """
  def create(pid, params) do
    GenServer.call(pid, {:create, params})
  end

  @doc """
    Send a request to update a given user given a set of params

    ID is the unique id of the user in the database 
    (can be obtained after creating it or via DankUserService.Client.Get).

    Params is a map with the informations you wish to update, 
    everything not mentioned will be left untouched.

    You call the function by using the servers PID, the users's ID and the values to be updated : 

        iex(1)> DankUserService.Client.Get.id(DankUserService.Server, 1)
        {:ok, %DankUserService.Models.User{username: "John Doe", ...}}
        iex(2)> DankUserService.Client.updat(DankUserService.Server, 1, %{username: "Not John Doe"})
        {:ok, %DankUserService.Models.User{username: "Not John Doe", ...}}

    The values given will be check for any errors and invalidated by DankUserService.Models.User.changeset/2 if needed.
    In case of success, it will return a tuple in the form of : 
        {:ok, %DankUserService.Models.User{...}}
    In case of error, a message will be provided as a string:
        {:error, ...cause...}
  """
  def update(pid, id, params) do
    GenServer.call(pid, {:update, id, params})
  end

  @doc """
    Send a request to delete a user given his ID

    ID is the unique ID of the user in the database

    Call the function using the servers PID and the user you wish to remove from the database.

        iex(1)> DankUserService.Client.delete(DankUserService.Server, 1)

    In case of success, it return a tuple with information about the deleted user : 
        {:ok, %DankUserService.Models.User{username: "John Doe", ...}}
    Else, it will return an error message which is a string:
        {:error, ...cause...}
  """
  def delete(pid, id) do
    GenServer.call(pid, {:delete, id})
  end
end

defmodule DankUserService.Client.Get do
  def all(pid) do
    GenServer.call(pid, {:get, :all})
  end

  def id(pid, val) do
    GenServer.call(pid, {:get, :id, val})
  end

  def username(pid, val) do
    GenServer.call(pid, {:get, :username, val})
  end

  def email(pid, val) do
    GenServer.call(pid, {:get, :email, val})
  end
end