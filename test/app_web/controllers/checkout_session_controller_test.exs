defmodule AppWeb.CheckoutSessionControllerTest do
  use AppWeb.ConnCase
  import App.ConnFixtures

  import Mock

  test "get redirection to stripe checkout session with loggedin user", %{conn: conn} do
    conn = setup_conn_with_user(conn)
    url_to_be_redirected_to = "www.session_url.com"

    with_mock Stripe.Session, [create: fn(_params) -> {:ok, %{url: url_to_be_redirected_to}} end] do

      conn = post(conn, ~p"/purchase/checkout-session", %{})

      assert redirected_to(conn, 303) == url_to_be_redirected_to
    end
  end
end
