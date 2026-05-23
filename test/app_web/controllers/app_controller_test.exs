defmodule AppWeb.AppControllerTest do
  use AppWeb.ConnCase
  import App.ConnFixtures

  test "dashboard with logged in user", %{conn: conn} do
    conn = setup_conn_with_user(conn, 42)
    conn = get(conn, ~p"/dashboard")
    # dbg(conn.status)
    assert redirected_to(conn, 302) == ~p"/"
  end

  test "dashboard with logged in and paid user", %{conn: conn} do
    UsersTable.create_user(%{stripe_id: 1, person_id: 1, status: true})
    conn = setup_conn_with_user(conn)

    conn = get(conn, ~p"/dashboard")
    assert html_response(conn, 200) =~ "nyan cat"
  end
end
