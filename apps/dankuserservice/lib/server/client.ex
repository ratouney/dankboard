defmodule DankUserService.Client do
  use GenServer
  @moduledoc """
  A module made to communicate with the DankUserService.
   
  This module handles changes made to the User database.
  To recieve data from it, use DankUserService.Client.Get

  First, run the corresponding server :
      iex(1)> {:ok, pid} = DankUserService.Server.start_link()
  
  Now use the PID in whichever function you need.
  You can also use the server module name as a PID, like this :
      iex(2)> DankUserService.Client.delete(DankUserService.Server, 1)
  (this will delete the user with the ID = 1)

  """ 

  @doc """
    Send a request to the database to create a user with the given params

    PID is the servers PID or you can give the DankUserService.Server modulename which is linked to the PID.
    Param is a map that will contain all the new users informations.

    ```elixir
    iex(1)> params = %{username: "John Doe", email: "john.doe@elixir.ex", password: "notpassword"}
    %{username: "John Doe", email: "john.doe@elixir.ex", password: "notpassword"}
    iex(2)> DankUserService.Client.create(DankUserService.Server, params)
    ```

    After being validated by `DankUserService.Models.User.changeset/2`.

    If successfull, it will return a tuple in the form of : 
        {:ok, %DankUserService.Models.User{...}}
    Else it will return an error as a string :
        {:error, errors}
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

    You call the function by using the servers PID or the servers modulename `DankUserService.Server`, the users's ID and the values to be updated : 

        iex(1)> DankUserService.Client.Get.id(DankUserService.Server, 1)
        {:ok, %DankUserService.Models.User{username: "John Doe", ...}}
        iex(2)> DankUserService.Client.update(DankUserService.Server, 1, %{username: "Not John Doe"})
        {:ok, %DankUserService.Models.User{username: "Not John Doe", ...}}

    The values given will be check for any errors and invalidated by DankUserService.Models.User.changeset/2 if needed.
    In case of success, it will return a tuple in the form of : 
        {:ok, %DankUserService.Models.User{...}}
    In case of error, a message will be provided as a string:
        {:error, errors}
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
        {:error, errors}
  """
  def delete(pid, id) do
    GenServer.call(pid, {:delete, id})
  end
end

defmodule DankUserService.Client.Get do
  @moduledoc """
    This module is an extension of the DankUserService.Client module which specialises in retrieving data

    All functions in this module only retrieve data from the server, if you wish to modifiy it, please use the DankUserService.Client module.
    The interact with the server, you must first run it : 

        iex(1)> DankUserService.Server.start_link()
  """

  @doc """
    This function retrieves all Users from the given server

    It returns a list of ```%DankUserService.Models.User{}``` structures

        iex(1)> DankUserService.Client.Get.all(DankUserService.Server)
        [
          %DankUserService.Models.User{...},
          %DankUserService.Models.User{...},
          %DankUserService.Models.User{...},
        ]
  """
  def all(pid) do
    GenServer.call(pid, {:get, :all})
  end

  @doc """
    This function searches for the given ID in the given server.

        iex(1)> DankUserService.Client.Get.id(DankUserService.Server, 1)

    If found, it return a tuple :
        {:ok, %DankUserService.Models.User{...}}
    Else it returns an error message in the form of a string :
        {:error, errors}
  """
  def id(pid, val) do
    GenServer.call(pid, {:get, :id, val})
  end

  @doc """
    This functions searches for the given username.

        iex(1)> DankUserService.Client.Get.username(DankUserService.Server, "ratouney")

    If found, it return :
        {:ok, %DankUserService.Models.User{...}}
    Else it returns and error with a message :
        {:error, errors}
  """
  def username(pid, val) do
    GenServer.call(pid, {:get, :username, val})
  end

  @doc """
    This functions searches for the given email.

        iex(1)> DankUserService.Client.Get.email(DankUserService.Server, "john.doe@gmail.com")

    If found, it return :
        {:ok, %DankUserService.Models.User{...}}
    Else it returns and error with a message :
        {:error, errors}
  """
  def email(pid, val) do
    GenServer.call(pid, {:get, :email, val})
  end
end