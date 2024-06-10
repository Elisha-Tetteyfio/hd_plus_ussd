defmodule HdPlusUssd.Menu.MainMenu do
  alias HdPlusUssd.Page
  def select_menu(body) do
    case body["menu"] do
      "main_menu" ->
        {:ok, Page.MainMenu.request_page}
    end
  end
end
