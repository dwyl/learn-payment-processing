defmodule UsersTable do

  alias Pockets

  @table :users_table

  def init do
    Pockets.new(@table, "cache.dets")
  end

  def list_users do
    Pockets.to_map(@table)
  end

  def create_user(%{:stripe_id => stripe_id, :person_id => person_id, :status => status}) do
    Pockets.put(@table, person_id, %{stripe_id: stripe_id, status: status})
  end

end
