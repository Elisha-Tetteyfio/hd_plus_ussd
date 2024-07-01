defmodule HdPlusUssd.Page.TestPages.FirstPage do
  alias HdPlusUssd.UssdSession
  def request_page(body) do
    update_trackers(body["msisdn"])
    %{"ussd_body" => display_message(), "msg_type" => "1"}
  end

  defp display_message do
    """
    This is the first page.

    1. Continue
    00. Back
    """
  end

  defp update_trackers(mobile_number) do
    UssdSession.update_session_table(mobile_number, :menu, :test_pages)
    UssdSession.update_session_table(mobile_number, :page, :first_page)
  end
end
