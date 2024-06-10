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
    |> put_resp_header("content-type", "application/json")
    |> send_resp(response_status, Poison.encode!(response))
  end

  get "/" do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Poison.encode!(%{message: "Hello world"}))
  end

  post "/" do
    {:ok, body, conn} = read_body(conn)
    {:ok, parsed_body} = Poison.decode(body)

    case Menu.MainMenu.select_menu(parsed_body) do
      {:ok, response} ->
        send_response(conn, 200, response)
      _ ->
        send_response(conn, 200, %{ussd_body: "System down", msg_type: '2'})
    end
  end
end
