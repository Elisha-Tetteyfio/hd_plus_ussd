defmodule HdPlusUssd.Menu.MainMenu do
  alias HdPlusUssd.Menu.TestPages
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
        select_menu(body)
      _ ->
        {:error, %{msg_type: "2", ussd_body: "End"}}
    end
  end

  defp select_menu(body) do
    case UssdSession.get_session_table(body["msisdn"]) do
      {:ok, session_data} ->
        case session_data[:menu] do
          :main_menu ->
            handle_response(body)
          :activate_device ->
            case ActivateDevice.select_page(body) do
              {:ok, response} ->
                {:ok, response}
              _ ->
                {:error}
            end
          :test_pages ->
            TestPages.select_page(body)
          _ ->
            {:error, }
        end
      _ ->
        {:error, "Something went wrong. Try again later."}
    end
  end

  defp handle_response(body) do
    case body["ussd_body"] do
      "1" ->
        {:ok, EnterNumber.request_page(body)}
      "2" ->
        {:ok, Page.TestPages.FirstPage.request_page(body)}
      "3" ->
        contact_info()
      _ ->
        {:ok, Page.MainMenu.request_page(body)}
    end
  end

  defp contact_info do
    {:ok, %{"ussd_body" => "Email: Contact@hdplus.com", "msg_type" => "2"}}
  end
end
