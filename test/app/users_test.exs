defmodule App.UsersTest do
  use ExUnit.Case

  # "Cache_test.dets" has one user

  setup_all do
    UsersTable.init()
    UsersTable.create_user(%{stripe_id: 1, person_id: 1, status: true})
    UsersTable.create_user(%{stripe_id: 2, person_id: 2, status: false})

    :ok
  end

  test "fetch user of person_id 1" do
    user = UsersTable.fetch_user(1)
    assert Map.get(user, :stripe_id) == 1
  end

  test "create user of person_id 3" do
    UsersTable.create_user(%{stripe_id: 3, person_id: 3, status: true})
    user = UsersTable.fetch_user(3)
    assert Map.get(user, :stripe_id) == 3
  end
end
