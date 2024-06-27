defmodule HdPlusUssd.Page.ActivateDevice.FinalPage do
  alias HdPlusUssd.Helpers.Formats
  alias HdPlusUssd.UssdSession
  def request_page(body) do
    update_trackers(body["msisdn"])
    %{"ussd_body" => display_message(body), "msg_type" => "2"}
  end

  defp display_message(body) do
    {:ok, selected_num} = UssdSession.get_session_data(body["msisdn"], :selected_hdp_num)

    """
    You have selected #{Formats.format_hdp_num(selected_num[:hdp_id])}
    """
  end

  defp update_trackers(mobile_number) do
    UssdSession.update_session_table(mobile_number, :menu, :activate_device)
    UssdSession.update_session_table(mobile_number, :page, :final_page)
  end
end
