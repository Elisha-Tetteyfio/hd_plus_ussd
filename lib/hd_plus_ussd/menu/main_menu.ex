defmodule HdPlusUssd.Menu.MainMenu do
  alias HdPlusUssd.UssdSession
  alias HdPlusUssd.Page
  alias Constants
  def process_request(body) do
    case body["msg_type"] do
      "0" ->
        UssdSession.create_session_table(body["msisdn"])
        {:ok, Page.MainMenu.request_page(body)}
      "1" ->
        {:ok, table} = UssdSession.get_session_table(body["msisdn"])
        select_menu(body, table)
      _ ->
        {:error, %{msg_type: "2", ussd_body: "End"}}
    end
  end

  defp select_menu(body, table) do
    case table[:menu] do
      "main_menu" ->
        {:ok, Page.MainMenu.request_page(body)}
      _ ->
        {:error, }
    end
  end
end
