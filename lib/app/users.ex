defmodule UsersTable do

  alias Pockets

  @table (if Mix.env() == :prod do :users_table else :users_test_table end)
  @filepath (if Mix.env() == :prod do "cache.dets" else "cache_test.dets" end)

  def init() do
    case Pockets.new(@table, @filepath) do
      # Not testing creating a table because when testing, it loads a sample table.
      # coveralls-ignore-start
      {:ok, set} -> {:ok, set}
      # coveralls-ignore-end
      {:error, _} ->
        Pockets.open(@table, @filepath)
    end
  end

  def create_user(%{:stripe_id => stripe_id, :person_id => person_id, :status => status}) do
    Pockets.put(@table, person_id, %{stripe_id: stripe_id, status: status})
  end

  def fetch_user(person_id) do
    Pockets.get(@table, person_id)
  end

end
