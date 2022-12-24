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

  def create_user(%{:stripe_id => stripe_id, :person_id => person_id}) do
    @table
    |> Set.wrap_existing!()
    |> Set.put_new( {person_id, stripe_id, false})
  end

  def update_payment_status(%{:person_id => person_id, :status => new_status}) do

    set = @table
    |> Set.wrap_existing!()

    {person_id, stripe_id, _status} = set
      |> Set.get!(person_id)

    set
    |> Set.put({person_id, stripe_id, new_status})
  end

end
