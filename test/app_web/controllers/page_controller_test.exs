defmodule AppWeb.PageControllerTest do
  use AppWeb.ConnCase
  import App.ConnFixtures

  import Mock

  test "get homepage", %{conn: conn} do
    conn = get(conn, ~p"/")

    assert html_response(conn, 200) =~
             "This is a small project showcasing how to integrate Stripe in a Phoenix project."
  end

  test "get success with loggedin user without session_id", %{conn: conn} do
    conn = setup_conn_with_user(conn)
    conn = get(conn, ~p"/purchase/success")
    assert redirected_to(conn, 303) == ~p"/"
  end

  test "get success with loggedin user with session_id", %{conn: conn} do
    conn = setup_conn_with_user(conn)

    with_mock Stripe.Session,
      retrieve: fn _session_id -> {:ok, %{customer: 1}} end do
      conn = get(conn, ~p"/purchase/success?session_id=123")

      assert html_response(conn, 200) =~
               "Thank you for completing your secure online payment."
    end
  end

  test "get success with loggedin user with session_id but stripe session errors out",
       %{conn: conn} do
    conn = setup_conn_with_user(conn)

    with_mock Stripe.Session, retrieve: fn _session_id -> {:error, nil} end do
      conn = get(conn, ~p"/purchase/success?session_id=123")
      assert redirected_to(conn, 303) == ~p"/"
    end
  end

  test "get cancel with loggedin user without session_id", %{conn: conn} do
    conn = setup_conn_with_user(conn)
    conn = get(conn, ~p"/purchase/cancel")
    assert redirected_to(conn, 303) == ~p"/"
  end

  test "get cancel with loggedin user with session_id", %{conn: conn} do
    conn = setup_conn_with_user(conn)

    with_mock Stripe.Session,
      retrieve: fn _session_id -> {:ok, %{customer: 1}} end do
      conn = get(conn, ~p"/purchase/cancel?session_id=123")

      assert html_response(conn, 200) =~ "looks like something went wrong"
    end
  end

  test "get cancel with loggedin user with session_id but stripe session errors out",
       %{conn: conn} do
    conn = setup_conn_with_user(conn)

    with_mock Stripe.Session, retrieve: fn _session_id -> {:error, nil} end do
      conn = get(conn, ~p"/purchase/cancel?session_id=123")
      assert redirected_to(conn, 303) == ~p"/"
    end
  end
end
