defmodule HdPlusUssd.Page.ActivateDevice.EnterNumber do
  alias HdPlusUssd.UssdSession
  def request_page(body) do
    update_trackers(body["msisdn"])
    %{"ussd_body" => display_message(), "msg_type" => "1"}
  end

  defp display_message do
    """
    SELECT HD+ NUMBER

    1. 012345678910
    2. 019876543210
    """
  end

  defp update_trackers(mobile_number) do
    UssdSession.update_session_table(mobile_number, :menu, :activate_device)
    UssdSession.update_session_table(mobile_number, :page, :enter_number)
  end
end
