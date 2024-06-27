defmodule HdPlusUssd.Helpers.Validations do
  def valid_option?(input, items) when is_integer(input) do
    input in 1..length(items)
  end
end
