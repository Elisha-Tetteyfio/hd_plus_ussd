defmodule HdPlusUssd.Schema.UssdCustHdpId do
  use Ecto.Schema
  # import Ecto.Changeset

  schema "ussd_cust_hdp_ids" do
    field(:hdp_id, :string)
    field(:mobile_number, :string)
  end

  # def changeset(hdp_ids, attrs) do

  # end
end
