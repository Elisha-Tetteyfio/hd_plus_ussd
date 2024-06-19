defmodule HdPlusUssd.Menu.MainMenu do
  alias HdPlusUssd.Page.ActivateDevice.EnterNumber
  alias HdPlusUssd.Menu.ActivateDevice
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
      :main_menu ->
        handle_response(body)
      :activate_device ->
        case ActivateDevice.select_page(body) do
          {:ok, response} ->
            {:ok, response}
          _ ->
            {:error}
        end
      _ ->
        {:error, }
    end
  end

  defp handle_response(body) do
    case body["ussd_body"] do
      "1" ->
        {:ok, EnterNumber.request_page(body)}
      _ ->
        {:ok, Page.MainMenu.request_page(body)}
    end
  end
end
