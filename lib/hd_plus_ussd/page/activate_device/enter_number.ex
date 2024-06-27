defmodule HdPlusUssd.Page.ActivateDevice.EnterNumber do
  import Ecto.Query
  alias HdPlusUssd.Helpers.Formats
  alias HdPlusUssd.Schema.UssdCustHdpId
  alias HdPlusUssd.Repo
  alias HdPlusUssd.UssdSession
  def request_page(body) do
    update_trackers(body["msisdn"])
    %{"ussd_body" => display_message(body["msisdn"]), "msg_type" => "1"}
  end

  defp display_message(mobile_number) do
    case user_hdp_numbers(mobile_number) do
      {:ok, numbers} ->
        msg = Enum.reduce(Enum.with_index(numbers), "SELECT HD+ NUMBER\n\n", fn {number, index}, arr ->
          arr <> "#{index+1}. #{Formats.format_hdp_num(number[:hdp_id])}\n"
        end)
        msg <> "\n00. BACK"
      {:error} ->
        {:error}
    end
  end

  defp update_trackers(mobile_number) do
    UssdSession.update_session_table(mobile_number, :menu, :activate_device)
    UssdSession.update_session_table(mobile_number, :page, :enter_number)
  end

  defp user_hdp_numbers(mobile_number) do
    case Repo.all(
      from(num in UssdCustHdpId, where: num.mobile_number == ^mobile_number,
      select: %{hdp_id: num.hdp_id})
    ) do
      [] ->
        {:error, }
      numbers ->
        UssdSession.update_session_table(mobile_number, :user_hdp_numbers, numbers)
        {:ok, numbers}
    end
  end
end
