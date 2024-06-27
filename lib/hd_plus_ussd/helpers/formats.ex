defmodule HdPlusUssd.Helpers.Formats do
  def format_hdp_num(hdp_num) do
    hdp_num
    |> String.graphemes()
    |> Enum.chunk_every(3)
    |> Enum.map(&Enum.join/1)
    |> Enum.join(" ")
  end
end
