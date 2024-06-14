defmodule HdPlusUssd.Menu.MainMenu do
  alias HdPlusUssd.Page
  alias Constants
  def process_request(body) do
    case body["msg_type"] do
      "0" ->
        # {:ok, %{"msg_type" => "1", "ussd_body" => "Hello worldhh"}}
        {:ok, Page.MainMenu.request_page}
      "1" ->
        {:ok, Page.MainMenu.request_page}
      _ ->
        IO.puts("Error")
        {:error, %{msg_type: "2", ussd_body: "End"}}
    end
  end
end
