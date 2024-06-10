defmodule HdPlusUssd do
  @moduledoc """
  Documentation for `HdPlusUssd`.
  """
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Poison.encode!(%{message: "Hello world"}))
  end
end
