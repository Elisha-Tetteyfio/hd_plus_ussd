defmodule HdPlusUssd.Menu.ActivateDevice do
  alias HdPlusUssd.Page
  alias HdPlusUssd.Page.ActivateDevice.FinalPage
  alias HdPlusUssd.Helpers.Validations
  alias HdPlusUssd.Page.ActivateDevice.EnterNumber
  alias HdPlusUssd.UssdSession

  def select_page(body) do
    {:ok, table} = UssdSession.get_session_table(body["msisdn"])

    case table[:page] do
      :enter_number ->
        case handle_response(body, :enter_number) do
          {:ok, response} ->
            {:ok, response}
        end
      _ ->
        {:error}
    end
  end

  defp handle_response(body, :enter_number) do
    {:ok, user_hdp_numbers} = UssdSession.get_session_data(body["msisdn"], :user_hdp_numbers)

    case body["ussd_body"] do
      "00" ->
        {:ok, Page.MainMenu.request_page(body)}
      _ ->
        case Integer.parse(body["ussd_body"]) do
          :error ->
            {:ok, EnterNumber.request_page(body)}
          {user_input, _} ->
            if Validations.valid_option?(user_input, user_hdp_numbers) do
              selected_hdp_num = Enum.at(user_hdp_numbers, user_input - 1)
              UssdSession.update_session_table(body["msisdn"], :selected_hdp_num, selected_hdp_num)
              {:ok, FinalPage.request_page(body)}
            else
              {:ok, EnterNumber.request_page(body)}
            end
        end
    end
  end
end
