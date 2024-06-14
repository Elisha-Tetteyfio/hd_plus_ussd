defmodule HdPlusUssd do
  @moduledoc """
  Documentation for `HdPlusUssd`.
  """
  alias HdPlusUssd.Menu
  use Plug.Router

  plug :match
  plug :dispatch

  def send_response(conn, response_status, response) do
    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(response_status, response)
  end

  get "/" do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Poison.encode!(%{message: "Hello world"}))
  end

  post "/" do
    {:ok, body, conn} = read_body(conn)
    {:ok, parsed_body} = Poison.decode(body)

    parsed_body = Map.put(parsed_body, "msg_type", "1")
    parsed_body = Map.put(parsed_body, "ussd_body", "Welcome to HD+")

    send_response(conn, 200, Poison.encode!(parsed_body))
  end
end
