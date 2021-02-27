defmodule RocketpayWeb.UsersController do

  use RocketpayWeb, :controller

  action_fallback RocketpayWeb.FallbackController

  alias Rocketpay.User

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rocketpay.create_user(params)do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
