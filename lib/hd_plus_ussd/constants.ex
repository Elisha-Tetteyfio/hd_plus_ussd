defmodule HdPlusUssd.Macro do
  defmacro const(name, value) do
    quote do
      def unquote(name)(), do: unquote(value)
    end
  end
end



defmodule Constants do
  import HdPlusUssd.Macro

  # Validation error messages
  # const :err_missing_id, %{ resp_code: "050", resp_msg: "Missing id in request" }
  # const :err_invalid_id, %{ resp_code: "051", resp_msg: "Invalid id" }

  # Constants
  const :first_session, "0"
  const :continue_session, %{ msg_type: "1"}
  const :end_session, %{ msg_type: "2"}

end
