defmodule HdPlusUssd.Page.MainMenu do
  def request_page do
    %{"ussd_body" => display_message(), "msg_type" => "1"}
  end

  def display_message do
    """
    WELCOME TO HD+

    1. Activate HD+ Device
    2. Buy HD+ Subscription
    3. Check Status
    4. Customer Service
    5. HD+ Super Dealer
    """
  end
end
