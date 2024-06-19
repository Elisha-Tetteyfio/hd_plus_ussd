defmodule HdPlusUssd.Menu.MainMenu do
  alias HdPlusUssd.UssdSession
  alias HdPlusUssd.Page
  alias Constants
  def process_request(body) do
    case body["msg_type"] do
      "0" ->
        UssdSession.create_session_table(body["msisdn"])
        # UssdSession.update_session_table(body["msisdn"], :menu, "main_me")
        {:ok, Page.MainMenu.request_page}
      "1" ->
        # {:ok, table} = UssdSession.get_session_table(body["msisdn"])
        {:ok, Page.MainMenu.request_page}
      _ ->
        {:error, %{msg_type: "2", ussd_body: "End"}}
    end
  end
end
