defmodule HdPlusUssd.Menu.TestPages do
  alias HdPlusUssd.Page
  alias HdPlusUssd.UssdSession
  def select_page(body) do
    {:ok, table} = UssdSession.get_session_table(body["msisdn"])

    case table[:page] do
      :first_page ->
        handle_response(body, :first_page)
      :second_page ->
        handle_response(body, :second_page)
      :third_page ->
        handle_response(body, :third_page)
      _ ->
        {:error}
    end
  end

  defp handle_response(body, :first_page) do
    case body["ussd_body"] do
      "00" ->
        {:ok, Page.MainMenu.request_page(body)}
      "1" ->
        {:ok, Page.TestPages.SecondPage.request_page(body)}
      _ ->
        {:ok, Page.TestPages.FirstPage.request_page(body)}
    end
  end

  defp handle_response(body, :second_page) do
    case body["ussd_body"] do
      "00" ->
        {:ok, Page.TestPages.FirstPage.request_page(body)}
      "1" ->
        {:ok, Page.TestPages.ThirdPage.request_page(body)}
      _ ->
        {:ok, Page.TestPages.SecondPage.request_page(body)}
    end
  end

  defp handle_response(body, :third_page) do
    case body["ussd_body"] do
      "00" ->
        {:ok, Page.TestPages.SecondPage.request_page(body)}
      "1" ->
        {:ok, end_session()}
      _ ->
        {:ok, Page.TestPages.ThirdPage.request_page(body)}
    end
  end

  defp end_session do
    %{"ussd_body" => "Thanks for using this service.", "msg_type" => "2"}
  end
end
