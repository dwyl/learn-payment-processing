defmodule UsersTable do

  alias ETS.Set

  @table :users_table

  def init do
    Set.new(name: @table)
  end

  def list_users do
    @table
    |> Set.wrap_existing!()
    |> Set.to_list()
  end

  def create_user(stripe_id) do
    @table
    |> Set.wrap_existing!()
    |> Set.put_new( {stripe_id, false})
  end

  def update_payment_status(%{:stripe_id => stripe_id, :status => status}) do
    @table
    |> Set.wrap_existing!()
    |> Set.put({stripe_id, status})
  end

end
