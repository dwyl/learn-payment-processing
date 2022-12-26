defmodule UsersTable do

  alias Pockets

  @table :users_table
  @filepath "cache.dets"

  def init do
    case Pockets.new(@table, @filepath) do
      {:ok, set} -> {:ok, set}
      {:error, _} ->
        Pockets.open(@table, @filepath)
    end
  end

  def list_users do
    Pockets.to_map(@table)
  end

  def create_user(%{:stripe_id => stripe_id, :person_id => person_id, :status => status}) do
    Pockets.put(@table, person_id, %{stripe_id: stripe_id, status: status})
  end

  def fetch_user(person_id) do
    Pockets.get(@table, person_id)
  end

end
