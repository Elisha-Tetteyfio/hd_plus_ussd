defmodule HdPlusUssd.Page.MainMenu do
  alias HdPlusUssd.UssdSession
  def request_page(body) do
    update_trackers(body["msisdn"])
    %{"ussd_body" => display_message(), "msg_type" => "1"}
  end

  defp display_message do
    """
    WELCOME TO HD+

    1. Activate HD+ Device
    2. Buy HD+ Subscription
    3. Check Status
    4. Customer Service
    5. HD+ Super Dealer
    """
  end

  defp update_trackers(mobile_number) do
    UssdSession.update_session_table(mobile_number, :menu, :main_menu)
  end
end
