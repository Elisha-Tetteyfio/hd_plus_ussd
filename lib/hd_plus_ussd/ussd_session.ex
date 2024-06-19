defmodule HdPlusUssd.UssdSession do
  use GenServer

  @table_name :ussd_session

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  # @impl true
  def init(:ok) do
    :ets.new(@table_name, [:named_table, :public, read_concurrency: true])
    {:ok, %{}}
  end

   # Public API to create a session table
  def create_session_table(mobile_number) do
    GenServer.call(__MODULE__, {:create_session_table, mobile_number})
  end

  def get_session_table(mobile_number) do
    GenServer.call(__MODULE__, {:get_session_table, mobile_number})
  end

  def update_session_table(mobile_number, key, value) do
    GenServer.call(__MODULE__, {:update_session_table, mobile_number, key, value})
  end

  def delete_session_table(mobile_number) do
    GenServer.call(__MODULE__, {:delete_session_table, mobile_number})
  end

  def handle_call({:create_session_table, mobile_number}, _from, state) do
    table_name = String.to_atom(mobile_number)

    case :ets.info(table_name) do
      :undefined ->
        table = :ets.new(table_name, [:set, :public, :named_table])
        {:reply, {:ok, table}, state}
      _ ->
        :ets.delete(table_name)
        table = :ets.new(table_name, [:set, :public, :named_table])
        {:reply, {:ok, table}, state}
    end
  end

  def handle_call({:get_session_table, mobile_number}, _from, state) do
    table_name = String.to_atom(mobile_number)

    case :ets.info(table_name) do
      :undefined ->
        {:reply, {:error, :table_not_found}, state}
      _ ->
        table_contents = get_session_table_contents(table_name)
        {:reply, {:ok, table_contents}, state}
    end
  end

  def handle_call({:update_session_table, mobile_number, key, value}, _from, state) do
    table_name = String.to_atom(mobile_number)

    case :ets.info(table_name) do
      :undefined ->
        {:reply, {:error, :table_not_found}, state}
      _ ->
        :ets.insert(table_name, {key, value})
        table_contents = get_session_table_contents(table_name)
        {:reply, {:ok, table_contents}, state}
    end
  end

  def handle_call({:delete_session_table, mobile_number}, _from, state) do
    table_name = String.to_atom(mobile_number)

    case :ets.info(table_name) do
      :undefined ->
        {:reply, {:ok, :table_not_found}, state}
      _ ->
        :ets.delete(table_name)
        {:reply, :ok, state}
    end
  end

  defp get_session_table_contents(table_name) do
    :ets.tab2list(table_name)
  end
end
