defmodule HdPlusUssd.Menu.ActivateDevice do
  alias HdPlusUssd.Page.ActivateDevice.EnterNumber
  alias HdPlusUssd.UssdSession
  def select_page(body) do
    {:ok, table} = UssdSession.get_session_table(body["msisdn"])

    case table[:page] do
      :enter_number ->
        case handle_response(body, :enter_number) do
          {:ok, response} ->
            {:ok, response}
          _ ->
            {:error}
        end
      _ ->
        {:error}
    end
  end

  defp handle_response(body, :enter_number) do
    case body["ussd_body"] do
      "1" ->
        {:ok, EnterNumber.request_page(body)}
      _ ->
        {:error, }
    end
  end
end
