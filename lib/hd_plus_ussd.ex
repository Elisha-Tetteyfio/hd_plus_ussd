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
    |> send_resp(response_status, response)
  end

  post "/" do
    {:ok, body, conn} = read_body(conn)
    {:ok, parsed_body} = Poison.decode(body)

    case Menu.MainMenu.process_request(parsed_body) do
      {:ok, response} ->
        send_response(conn, 200, Poison.encode!(Map.merge(parsed_body, response)))
      {:error, reason} ->
        error_body = %{"msg_type" => "2", "ussd_body" => reason}
        send_response(conn, 200, Poison.encode!(Map.merge(parsed_body, error_body)))
      _ ->
        send_response(conn, 200, Poison.encode!(Map.merge(parsed_body, %{ussd_body: "Service currently unavailable.", msg_type: "2"})))
    end
  end
end
