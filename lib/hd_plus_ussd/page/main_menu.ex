defmodule HdPlusUssd.Page.MainMenu do
  def request_page do
    %{ussd_body: display_message(), msg_type: "1"}
  end

  def display_message do
    """
    Welcome to HD+
    1. Add subscription
    2. Contact us
    """
  end
end
